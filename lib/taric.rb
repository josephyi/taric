require 'taric/client'
require 'taric/configuration'
require 'taric/connection'
require 'taric/version'
require 'typhoeus/adapters/faraday'
require 'memoist'

module Taric
  class << self
    attr_accessor :configuration

    def client(region: :na, config: @configuration ||= Taric::Configuration.new)
      Taric::Client.new(api_key: config.api_key,
                        region: region,
                        requestor: config.requestor.(connection(config)),
                        response_handler: config.response_handler)
    end

    # Sets global configuration.
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
    #
    def reset!
      @configuration = Taric::Configuration.new
    end

    include Taric::Connection
  end

end


