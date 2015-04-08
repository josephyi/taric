module Taric
  class Configuration
    attr_accessor :api_key, :format, :user_agent, :connection_opts, :adapter, :region, :requestor, :response_handler, :parallel_requestor, :parallel_response_handler

    DEFAULT_REQUESTOR = -> connection, url {
      connection.get url
    }.curry

    DEFAULT_RESPONSE_HANDLER = -> response {
      response.body
    }

    PARALLEL_REQUESTOR = -> connection, urls {
      urls.map{|url| connection.get url}
    }.curry

    PARALLEL_RESPONSE_HANDLER = -> responses {
      responses.map{|response| {body: response.body, status: response.status}}
    }

    def initialize(options = {})
      @api_key = options.fetch(:api_key, ENV.fetch('RIOT_API_KEY'.freeze, nil))
      @format = options.fetch(:format, :json)
      @user_agent = options.fetch(:user_agent, 'Taric Gem')
      @adapter = options.fetch(:adapter, Faraday.default_adapter)
      @region = options.fetch(:region, ENV.fetch('RIOT_API_REGION'.freeze, 'na').to_sym)
      @connection_opts = options.fetch(:connection_opts, {})
      @requestor = options.fetch(:requestor, DEFAULT_REQUESTOR)
      @response_handler = options.fetch(:response_handler, DEFAULT_RESPONSE_HANDLER)
      @parallel_requestor = options.fetch(:parallel_requestor, PARALLEL_REQUESTOR)
      @parallel_response_handler = options.fetch(:parallel_response_handler, PARALLEL_RESPONSE_HANDLER)
    end
  end
end