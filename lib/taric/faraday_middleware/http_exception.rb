require 'faraday'

module Taric
  module FaradayMiddleware
    class Unauthorized < StandardError; end
    class BadRequest < StandardError; end
    class RateLimitExceeded < StandardError; end
    class InternalServerError < StandardError; end
    class ServiceUnavailable < StandardError; end
    class GatewayTimeout < StandardError; end
    class Forbidden < StandardError; end
    class NotFound < StandardError; end

    class HttpException < Faraday::Response::Middleware
      def call(env)
        default_request(env) if env.parallel_manager.nil? # might need a better way of detecting this
      end

      def default_request(env)
        @app.call(env).on_complete do |response|
          case response[:status]
            when 400
              raise Taric::FaradayMiddleware::BadRequest, 'Bad parameter, check API documentation'
            when 401
              raise Taric::FaradayMiddleware::Unauthorized, 'Check API key'
            when 403
              raise Taric::FaradayMiddleware::Forbidden, 'Forbidden'
            when 404
              raise Taric::FaradayMiddleware::NotFound, 'Data not found'
            when 429
              raise Taric::FaradayMiddleware::RateLimitExceeded, 'Rate limit exceeded'
            when 500
              raise Taric::FaradayMiddleware::InternalServerError, 'Internal server error'
            when 503
              raise Taric::FaradayMiddleware::ServiceUnavailable, 'Service unavailable'
            when 504
              raise Taric::FaradayMiddleware::GatewayTimeout, 'Gateway timeout'
          end
        end
      end
    end
  end
end