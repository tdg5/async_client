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
          jid = enqueue_options[:id]
          qless_enqueue_options = {}
          qless_enqueue_options[:jid] = jid if jid
          qless_queue.put(unit_of_work, data, qless_enqueue_options)
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

        def recur(data, options)
          job_class = options.fetch(:class)
          frequency = options.fetch(:frequency)
          @client.recur(job_class, data, frequency, options)
        end

        def schedule(data, options)
          job_class = options.fetch(:class)
          _delay = options.fetch(:delay)
          queue_name = option.fetch(:queue_name)
          q = queue(queue_name)
          q.put(job_class, data, options)
        end
      end
    end
  end
end
