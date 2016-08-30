require "qless"
require "async_client/clients/qless/client"

module AsyncClient
  module Clients
    module Qless
      class ClientFactory
        def initialize(config = {})
          @config = config
        end

        def product
          return @client if @client
          client_config = {}
          client_config[:host] = @config[:host] if @config.key?(:host)
          client_config[:port] = @config[:port] if @config.key?(:port)
          qless_client = ::Qless::Client.new(client_config)
          qless_async_client = AsyncClient::Clients::Qless::Client.new(qless_client)
          @client = qless_async_client
        end
      end
    end
  end
end
