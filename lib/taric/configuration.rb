module Taric
  class Configuration
    attr_accessor :api_key, :format, :user_agent, :connection_opts, :adapter, :region, :requestor, :response_handler, :parallel_requestor, :parallel_response_handler, :raw

    DEFAULT_REQUESTOR = -> (connection, method, url, body, headers) {
      connection.send(method, url, body, headers)
    }.curry

    DEFAULT_RESPONSE_HANDLER = -> response {
      response
    }

    PARALLEL_REQUESTOR = -> connection, operations {
      operations.map{|operation| connection.send(operation[:method], operation[:url], operation[:body], operation[:headers])}
    }.curry

    PARALLEL_RESPONSE_HANDLER = -> responses {
      responses.map{|response| response}
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
      @raw = options.fetch(:raw, false)
    end
  end
end