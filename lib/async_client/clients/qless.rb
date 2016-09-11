require "async_client"
require "qless"
require "async_client/clients/qless/client"
require "async_client/clients/qless/client_factory"
require "async_client/jobs/qless/ram_reclamation_job"

module AsyncClient
  module Clients
    module Qless
      def self.build_qless_client(client_config)
        AsyncClient::Clients::Qless::ClientFactory.build_qless_client(client_config)
      end

      def self.build_async_client(client_config)
        AsyncClient::Clients::Qless::ClientFactory.build_async_client(client_config)
      end

      def self.build_qless_async_client(client_config)
        AsyncClient::Clients::Qless::ClientFactory.build_qless_async_client(client_config)
      end
    end
  end
end
