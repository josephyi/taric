require 'taric/client'
require 'taric/configuration'
require 'taric/connection'
require 'taric/version'
require 'typhoeus/adapters/faraday'
require 'memoist'

module Taric
  class << self
    extend Memoist
    attr_accessor :configuration

    def client(region = :na, config = @configuration ||= Taric::Configuration.new)
      Taric::Client.new(config.api_key, region, config.requestor.(connection(config)), config.response_handler)
    end
    memoize :client

    def configure!
      reset!
      yield(configuration)
    end

    def reset!
      @configuration = Taric::Configuration.new
    end

    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    def respond_to?(method, include_all=false)
      client.respond_to?(method, include_all) || super
    end

    include Taric::Connection
  end

end


