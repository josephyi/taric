require 'spec_helper'

describe Faraday::Response do
  let(:client) { Taric.client(api_key: 'test') }
  let (:url) { expand_template(Taric::Operation::LolStaticData::STATIC_LANGUAGES) }
  {
      400 => Taric::FaradayMiddleware::BadRequest,
      401 => Taric::FaradayMiddleware::Unauthorized,
      403 => Taric::FaradayMiddleware::Forbidden,
      404 => Taric::FaradayMiddleware::NotFound,
      429 => Taric::FaradayMiddleware::RateLimitExceeded,
      500 => Taric::FaradayMiddleware::InternalServerError,
      503 => Taric::FaradayMiddleware::ServiceUnavailable,
      504 => Taric::FaradayMiddleware::GatewayTimeout
  }.each do |status, exception|
    context "when HTTP status is #{status}" do
      before { stub_get(url).to_return(status: status) }

      it "should raise #{exception.name} error" do
        expect { client.static_languages }.to raise_error(exception)
      end

    end
  end

end
