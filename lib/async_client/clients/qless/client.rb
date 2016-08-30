module AsyncClient
  module Clients
    module Qless
      class Client
        def initialize(qless_client)
          @client = qless_client
        end

        def enqueue(queue_name, job_class, data)
          q = queue(queue_name)
          q.put(job_class, data)
        end

        def pop(queue_name)
          q = queue(queue_name)
          q.pop
        end

        def queue(queue_name)
          @client.queues[queue_name]
        end

        def queues
          @client.queues
        end
      end
    end
  end
end
