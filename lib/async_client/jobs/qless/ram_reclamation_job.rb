require "async_client/unit_of_work"
require "pry"

module AsyncClient
  module Jobs
    module Qless
      class RAMReclamationJob
        include AsyncClient::UnitOfWork

        DEFAULT_QUEUE = "system"

        BLACKLIST_PATTERNS = [
          /^ql:config$/,
          /^ql:j:/,
          /^ql:paused_queues$/,
          /^ql:q:/,
          /^ql:queues$/,
          /^ql:r:/,
          /^ql:s:/,
          /^ql:t:/,
          /^ql:tags$/,
          /^ql:th:/,
          /^ql:tracked$/,
          /^ql:w:/,
          /^ql:workers$/,
          /^qmore/,
        ].freeze

        REDIS_USED_MEMORY = "used_memory".freeze

        def blacklist_patterns
          self.class.const_get(:BLACKLIST_PATTERNS)
        end

        def exec
          return unless max_used_memory_exceeded?
          cursor = 0
          while cursor != "0"
            cursor, keys = redis_client.scan(cursor, :count => 100)
            keys.each do |key|
              next if blacklist_patterns.any? { |patt| patt === key }
              redis_client.del(key)
            end
          end
        end

        def max_used_memory_exceeded?
          redis_client.info[REDIS_USED_MEMORY].to_i > @max_memory_used_bytes.to_i
        end

        def redis_client
          async_client.redis
        end
      end
    end
  end
end
