require_relative 'operation/api'
require 'memoist'
module Taric
  class Client
    include Taric::Operation::API

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

    # @param api_key [String] rito api key
    # @param region [Symbol] region code
    # @param requestor [Proc] lambda that will accept a url and return a [Faraday::Response]
    # @param response_handler [Proc] lambda that accepts [Faraday::Response] and handles it
    #
    def initialize(api_key:, region:, requestor:, response_handler:)
      @api_key = api_key
      @region = region
      @requestor = requestor
      @response_handler = response_handler
    end

    class << self
      extend Memoist

      # @note Memoized
      #
      # Sets up and returns hash of api key and region values.
      #
      # @params api_key [String] rito api key
      # @params region [Symbol] key for region
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
      url = self.class.expand_template(api_key: @api_key, region: @region, operation: operation, options: options)
      API_CALL.(url: url, requestor: @requestor, response_handler: @response_handler)
    end
  end
end