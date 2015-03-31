require 'faraday_middleware/parse_oj'
require 'taric/faraday_middleware/http_exception'

module Taric
  module Connection
    def connection(config)
      options = {
          :headers => {'Accept' => "application/#{config.format}; charset=utf-8", 'User-Agent' => config.user_agent}
      }.merge(config.connection_opts)

      Faraday::Connection.new(options) do |conn|
        conn.use Taric::FaradayMiddleware::HttpException
        conn.response :oj, :content_type => /\bjson$/
        conn.adapter config.adapter
      end
    end
  end
end