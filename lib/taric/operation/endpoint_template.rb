require 'addressable/template'

module Taric
  module Operation
    class EndpointTemplate
      attr_accessor :template_url, :method, :body, :headers
      def initialize(template_url:, method: :get, body: nil, headers: {})
        @template_url = Addressable::Template.new(template_url)
        @method = method
        @body = body
        @headers = headers
      end
    end
  end
end
