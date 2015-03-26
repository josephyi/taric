module Taric
  class Configuration
    attr_accessor :api_key, :format, :user_agent, :connection_opts, :adapter, :region, :requestor, :response_handler

    DEFAULT_REQUESTOR = -> connection, url {
      connection.get url
    }.curry

    DEFAULT_RESPONSE_HANDLER = -> response {
      raise "#{response.status}" if response.status >= 400
      response.body
    }

    def initialize(options = {})
      @api_key = options.fetch(:api_key, ENV.fetch('RIOT_API_KEY'.freeze, nil))
      @format = options.fetch(:format, :json)
      @user_agent = options.fetch(:user_agent, 'Taric Gem')
      @adapter = options.fetch(:adapter, :typhoeus)
      @region = options.fetch(:region, ENV.fetch('RIOT_API_REGION'.freeze, 'na').to_sym)
      @connection_opts = options.fetch(:connection_opts, {})
      @requestor = options.fetch(:requestor, DEFAULT_REQUESTOR)
      @response_handler = options.fetch(:response_handler, DEFAULT_RESPONSE_HANDLER)
    end
  end
end