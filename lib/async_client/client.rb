module AsyncClient
  class Client
    def initialize(concrete_client)
      @client = concrete_client
    end

    def enqueue(data, enqueue_options)
      @client.enqueue(data, enqueue_options)
    end

    def pop(queue_name)
      @client.pop(queue_name)
    end

    def queue(queue_name)
      @client.queue(queue_name)
    end

    def queues
      @client.queues
    end
  end
end
