require "async_client/client"
require "qless"
require "async_client/clients/qless/client"
require "async_client/clients/qless/client_factory"


module AsyncClient
  module Clients
    module Qless
      def self.build_async_client(host, port)
        qless_async_client = build_qless_async_client(host, port)
        AsyncClient::Client.new(qless_async_client)
      end

      def self.build_qless_async_client(host, port)
        factory = ClientFactory.new(:host => host, :port => port)
        factory.product
      end
    end
  end
end
