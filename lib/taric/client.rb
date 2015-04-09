require_relative 'operation/api'
require 'memoist'
require_relative 'connection'
module Taric
  class Client
    include Taric::Connection
    include Taric::Operation::API
    attr_reader :api_key, :region, :conn, :config

    REGION_ENDPOINT_INFO = {
        br: {region: 'br'.freeze, platform_id: 'BR1'.freeze, host: 'br.api.pvp.net'},
        eune: {region: 'eune'.freeze, platform_id: 'EUN1'.freeze, host: 'eune.api.pvp.net'},
        euw: {region: 'euw'.freeze, platform_id: 'EUW1', host: 'euw.api.pvp.net'},
        kr: {region: 'kr'.freeze, platform_id: 'KR', host: 'kr.api.pvp.net'},
        lan: {region: 'lan'.freeze, platform_id: 'LA1', host: 'lan.api.pvp.net'},
        las: {region: 'las'.freeze, platform_id: 'LA2', host: 'las.api.pvp.net'},
        na: {region: 'na'.freeze, platform_id: 'NA1', host: 'na.api.pvp.net'},
        oce: {region: 'oce'.freeze, platform_id: 'OC1', host: 'oce.api.pvp.net'},
        tr: {region: 'tr'.freeze, platform_id: 'TR1', host: 'tr.api.pvp.net'},
        ru: {region: 'ru'.freeze, platform_id: 'RU', host: 'ru.api.pvp.net'},
        pbe: {region: 'pbe'.freeze, platform_id: 'PBE1', host: 'pbe.api.pvp.net'}
    }.freeze

    REGION_ENDPOINT_STRING_KEYS = REGION_ENDPOINT_INFO.keys.map(&:to_s).freeze

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
      # @return [Addressable::URI] of expanded template
      #
      # @example
      #   Taric::Client.expand_template(api_key: 'ritokey', region: :na, operation: Taric::Operation::Champion::CHAMPIONS)
      def expand_template(api_key:, region:, operation:, options: {})
        operation.expand(options.merge(operation_values(api_key: api_key, region: region)))
      end
    end

    private
    def response_for(operation, options = {})
      -> url {
        API_CALL.(url: url, requestor: @config.requestor.(@conn), response_handler: @config.response_handler)
      }.(self.class.expand_template(api_key: @api_key, region: @region, operation: operation, options: options))
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
        }.(API_CALL.(url: @operations, requestor: @parent.config.parallel_requestor.(@parent.conn), response_handler: @parent.config.parallel_response_handler))
      end

      private

      def response_for(operation, options = {})
        @operations << @parent.class.expand_template(api_key: @parent.api_key, region: @parent.region, operation: operation, options: options)
        self
      end

    end
  end
end