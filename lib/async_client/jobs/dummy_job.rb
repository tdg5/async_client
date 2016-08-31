module AsyncClient
  module Jobs
    class DummyJob
      include AsyncClient::UnitOfWork

      DEFAULT_QUEUE = "test"

      def exec
        puts @msg || "#{Process.pid} :: DummyJob"
      end
    end
  end
end
