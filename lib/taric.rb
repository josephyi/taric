require 'taric/client'
require 'taric/configuration'
require 'taric/connection'
require 'taric/version'
require 'typhoeus/adapters/faraday'
require 'memoist'

module Taric
  class << self
    attr_accessor :configuration

    # Creates a [Taric::Client], the main interface to the LoL API. If the api_key is provided
    # in .configure!, then only the region needs to be set. If .configure! is used, but a different
    # api_key is provided, then the latter takes precedence.
    #
    # @see Taric::Client::REGION_ENDPOINT_INFO
    # @param region [Symbol] region code, also accepts [String], default is :na
    # @param api_key [String] rito API key
    # @param config [Taric::Configuration] configuration options. If not provided, then defaults will be used.
    #
    # @return [Taric::Client]
    #
    # @example
    #   # With .configure! (preferred)
    #   Taric.configure! do |config|
    #     config.api_key = 'your-rito-api-key'
    #   end
    #
    #   client = Taric.client(region: :na)
    #
    #   # With arbitrary key.
    #   client = Taric.client(region: :na, api_key: 'your-rito-key')
    def client(region: :na, api_key: nil, config: @configuration ||= Taric::Configuration.new)
      Taric::Client.new(api_key: api_key || config.api_key,
                        region: region.is_a?(String) ? region.to_sym : region,
                        requestor: config.requestor.(connection(config)),
                        response_handler: config.response_handler)
    end

    # Sets global configuration. Should only be called once in a process (e.g. Rails initializer)
    #
    # @see Taric::Configuration
    #
    # @example
    #   Taric.configure! do |config|
    #     config.api_key = 'your_api_key'
    #   end
    def configure!
      reset!
      yield(configuration)
    end

    # Resets global configuration.
    # @see Taric::Configuration
    def reset!
      @configuration = Taric::Configuration.new
    end

    include Taric::Connection
  end

end


