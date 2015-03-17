$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage(99.12)
end

require 'taric'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'coveralls.io')

def stub_get(url)
  stub_request(:get, url)
end

def a_get(url)
  a_request(:get, url)
end

def fixture(file)
  File.new("#{File.expand_path("../fixtures", __FILE__)}/#{file}")
end

def expand_template(operation, options = {})
  Taric::Client.expand_template(api_key: 'KeyNotSetButUsingThisForTest', region: :na, operation: operation, options: options).to_s
end

def stub_get_json(url, fixture)
  stub_request(:get, url).to_return(body: fixture(fixture), headers: {content_type: 'application/json; charset=utf-8'})
end