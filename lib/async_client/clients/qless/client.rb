module AsyncClient
  module Clients
    module Qless
      class Client
        def initialize(qless_client)
          @client = qless_client
        end

        def enqueue(data, enqueue_options)
          unit_of_work = enqueue_options.fetch(:unit_of_work)
          queue_name = enqueue_options.fetch(:queue)
          qless_queue = queue(queue_name)
          qless_queue.put(unit_of_work, data)
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
