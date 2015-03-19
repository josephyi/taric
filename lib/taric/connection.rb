require 'faraday_middleware'

module Taric
  module Connection
    def connection(config)
      options = {
          :headers => {'Accept' => "application/#{config.format}; charset=utf-8", 'User-Agent' => config.user_agent}
      }.merge(config.connection_opts)

      Faraday::Connection.new(options) do |conn|
        #conn.use FaradayMiddleware::Mashify
        #conn.response :raise_error
        conn.response :json, :content_type => /\bjson$/
        conn.adapter config.adapter
      end
    end
  end
end