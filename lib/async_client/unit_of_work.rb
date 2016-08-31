module AsyncClient
  module UnitOfWork
    def self.included(descendent)
      descendent.extend(ClassMethods)
    end

    module ClassMethods
      DEFAULT_QUEUE = "default".freeze

      def default_queue
        const_get(:DEFAULT_QUEUE)
      end

      def enqueue(data = {}, enqueue_options = {})
        enqueue_options[:unit_of_work] = name
        enqueue_options[:queue] ||= default_queue
        async_client = enqueue_options.fetch(:async_client)
        async_client.enqueue(data, enqueue_options)
      end

      def exec_instance(instance)
        instance.before_exec if instance.respond_to?(:before_exec)
        if instance.respond_to?(:around_exec)
          instance.around_exec
        else
          instance.exec
        end
        instance.after_exec if instance.respond_to?(:after_exec)
      end

      def perform(async_job)
        instance = new
        instance.import_data(async_job.data)
        instance.instance_variable_set(:@async_job, async_job)
        exec_instance(instance)
      end
    end

    attr_reader :async_job

    def exec
    end

    def import_data(data)
      data.each { |key, value| instance_variable_set("@#{key}", value) }
    end
  end
end
