require 'faraday_middleware/parse_oj'

module Taric
  module Connection
    def connection(config)
      options = {
          request: {:params_encoder => Faraday::FlatParamsEncoder },
          headers: {'Accept' => "application/#{config.format}; charset=utf-8", 'User-Agent' => config.user_agent}
      }.merge(config.connection_opts)

      Faraday::Connection.new(options) do |conn|
        conn.response :oj, content_type: /\bjson$/ unless config.raw
        conn.adapter config.adapter
      end
    end
  end
end