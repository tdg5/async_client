require "qless"
require "async_client/clients/qless/client"

module AsyncClient
  module Clients
    module Qless
      class ClientFactory
        ONE_MINUTE = 60
        FIVE_MINUTES = 5 * 60

        def self.build_async_client(client_config)
          qless_async_client = build_qless_async_client(client_config)
          AsyncClient::Client.new(qless_async_client)
        end

        def self.build_qless_async_client(client_config)
          qless_client = build_qless_client(client_config)
          qless_async_client = AsyncClient::Clients::Qless::Client.new(qless_client)
          qless_async_client
        end

        def self.build_qless_client(client_config)
          qless_client = ::Qless::Client.new(client_config)
          qless_client.config['heartbeat'] = FIVE_MINUTES
          qless_client.config['jobs-history'] = FIVE_MINUTES
          qless_client.config['jobs-history-count'] = 100
          qless_client.config['max-worker-age'] = ONE_MINUTE
          qless_client
        end
      end
    end
  end
end
