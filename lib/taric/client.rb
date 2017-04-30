require_relative 'operation/api'
require 'memoist'
require_relative 'connection'
module Taric
  class Client
    include Taric::Connection
    include Taric::Operation::API
    attr_reader :api_key, :region, :conn, :config

    REGION_ENDPOINT_INFO = {
        br: {region: 'br'.freeze, platform_id: 'BR1'.freeze, host: 'br1.api.riotgames.com'.freeze},
        eune: {region: 'eune'.freeze, platform_id: 'EUN1'.freeze, host: 'eun1.api.riotgames.com'.freeze},
        euw: {region: 'euw'.freeze, platform_id: 'EUW1'.freeze, host: 'euw1.api.riotgames.com'.freeze},
        jp: {region: 'jp'.freeze, platform_id: 'JP1'.freeze, host: 'jp1.api.riotgames.com'.freeze},
        kr: {region: 'kr'.freeze, platform_id: 'KR'.freeze, host: 'kr.api.riotgames.com'.freeze},
        lan: {region: 'lan'.freeze, platform_id: 'LA1'.freeze, host: 'la1.api.riotgames.com'.freeze},
        las: {region: 'las'.freeze, platform_id: 'LA2'.freeze, host: 'la2.api.riotgames.com'.freeze},
        na: {region: 'na'.freeze, platform_id: 'NA1'.freeze, host: 'na1.api.riotgames.com'.freeze},
        oce: {region: 'oce'.freeze, platform_id: 'OC1'.freeze, host: 'oc1.api.riotgames.com'.freeze},
        tr: {region: 'tr'.freeze, platform_id: 'TR1'.freeze, host: 'tr1.api.riotgames.com'.freeze},
        ru: {region: 'ru'.freeze, platform_id: 'RU'.freeze, host: 'ru.api.riotgames.com'.freeze},
        pbe: {region: 'pbe'.freeze, platform_id: 'PBE1'.freeze, host: 'pbe1.api.riotgames.com'.freeze}
    }.freeze

    REGION_ENDPOINT_STRING_KEYS = REGION_ENDPOINT_INFO.keys.map(&:to_s).freeze

    # New instance of Taric::Client.
    #
    # @param api_key [String] rito api key
    # @param region [Symbol] region code
    # @param config [Configuration] configuration
    def initialize(api_key:, region:, config:) #requestor:, response_handler:)
      raise ArgumentError, 'api_key cannot be nil' if api_key.nil?
      raise ArgumentError, 'region cannot be nil' if region.nil?
      raise ArgumentError, "#{region} is not a valid region, #{REGION_ENDPOINT_STRING_KEYS}" if REGION_ENDPOINT_INFO[region].nil?
      @api_key = api_key
      @region = region
      @config = config
      @conn = connection(config)
      # @requestor = requestor
      # @response_handler = response_handler
    end

    # Returns a ParallelClient that will execute operations in parallel.
    # @return [ParallelClient]
    def in_parallel
      ParallelClient.new(self)
    end

    class << self
      extend Memoist

      # @note Memoized
      #
      # Sets up and returns hash of api key and region values.
      #
      # @param api_key [String] rito api key
      # @param region [Symbol] key for region
      # @return [Hash] of api_key and region info
      def operation_values(api_key:, region:)
        {api_key: api_key}.merge!(REGION_ENDPOINT_INFO[region])
      end
      memoize :operation_values

      # Expands operation template with api_key, region, and option values.
      #
      # @param api_key [String] rito api key
      # @param region [Symbol] key for region
      # @param operation [Addressable::Template] URI template for operation
      # @param options [Hash] optional, values for template
      # @return [String] of expanded template
      #
      # @example
      #   Taric::Client.expand_template(api_key: 'ritokey', region: :na, operation: Taric::Operation::Champion::CHAMPIONS)
      def expand_template(api_key:, region:, operation:, options: {})
        result = operation.expand(options.merge(operation_values(api_key: api_key, region: region)))
        puts result
        result
      end
    end

    private
    def response_for(operation, options = {})
      -> (method, url, body, headers) {
        API_CALL.(method, url, body, headers, @config.requestor.(@conn), @config.response_handler)
      }.(operation.method, self.class.expand_template(api_key: @api_key, region: @region, operation: operation.template_url, options: options), operation.body, operation.headers)
    end

    class ParallelClient
      include Taric::Operation::API
      def initialize(parent)
        @parent = parent
        @operations = []
      end

      # Processes all chained requests, clears operations, and returns responses with respect to the operations.
      #
      # @return [Array] of operation responses, default is hash with response status and body.
      #
      # @example
      #   client.in_parallel.match(id: 1).match(id: 42).featured_games.execute!
      #
      def execute!
        -> responses {
          @operations.clear
          responses
        }.(@parent.config.parallel_response_handler.(@parent.config.parallel_requestor.(@parent.conn, @operations)))
      end

      private

      def response_for(operation, options = {})
        @operations << {url: @parent.class.expand_template(api_key: @parent.api_key, region: @parent.region, operation: operation.template_url, options: options), method: operation.method, body: operation.body, headers: operation.headers}
        self
      end

    end
  end
end
