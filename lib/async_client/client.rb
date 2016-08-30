module AsyncClient
  class Client
    def initialize(concrete_client)
      @client = concrete_client
    end

    def enqueue(queue_name, job_class, data)
      @client.enqueue(queue_name, job_class, data)
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
