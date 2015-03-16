$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'taric'
require 'webmock/rspec'

def stub_get(url)
  stub_request(:get, url)
end

def a_get(url)
  a_request(:get, url)
end

def fixture(file)
  File.new("#{File.expand_path("../fixtures", __FILE__)}/#{file}")
end