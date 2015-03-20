require 'spec_helper'

describe Taric do
  it 'has a version number' do
    expect(Taric::VERSION).not_to be nil
  end

  describe "#configure!" do
    after {Taric.reset!}

    it 'configures defined params' do
      Taric.configure! do |config|
        config.api_key = 'test'
      end

      client = Taric.client(region: :na)
      expect(client.instance_variable_get '@api_key').to eq('test')
    end
  end

end
