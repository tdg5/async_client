module AsyncClient
  module Jobs
    class DummyJob
      def self.perform(job)
        puts job.data["msg"] || "#{Process.pid} :: DummyJob"
      end
    end
  end
end
