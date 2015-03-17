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

    class << self
      extend Memoist
      def operation_values(api_key:, region:)
        {api_key: api_key}.merge!(Taric::Operation::API::REGION_ENDPOINT_INFO[region])
      end
      memoize :operation_values

      def expand_template(api_key:, region:, operation:, options: {})
        operation.expand(options.merge(operation_values(api_key: api_key, region: region)))
      end
    end

    private
    def response_for(operation, options = {})
      url = self.class.expand_template(api_key: @api_key, region: @region, operation: operation, options: options)
      API_CALL.(url: url, requestor: @requestor, response_handler: @response_handler)
    end
  end
end