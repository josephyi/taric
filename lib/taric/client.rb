require_relative 'operation/api'
require 'memoist'
module Taric
  class Client
    include Taric::Operation::API

    def initialize(api_key, region, requestor, response_handler)
      @api_key = api_key
      @region = region
      @requestor = requestor
      @response_handler = response_handler
    end

    def expand_template(operation, options = {})
      operation.expand(options.merge(self.class.operation_values(@api_key, @region)))
    end

    private
    def response_for(operation, options = {})
      RESPONSE.(expand_template(operation, options), @requestor, @response_handler)
    end

    class << self
      extend Memoist
      def operation_values(api_key, region)
        {api_key: api_key}.merge!(Taric::Operation::API::REGION_ENDPOINT_INFO[region]).freeze
      end
    end

  end
end