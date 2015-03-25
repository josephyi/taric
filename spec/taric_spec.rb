require 'spec_helper'

describe Taric do
  it 'has a version number' do
    expect(Taric::VERSION).not_to be nil
  end

  describe ".configure!" do
    after {Taric.reset!}

    it 'configures defined params' do
      Taric.configure! do |config|
        config.api_key = 'test'
      end

      client = Taric.client(region: :na)
      expect(client.instance_variable_get '@api_key').to eq('test')
    end
  end

  describe ".client" do
     it 'raises when api_key is nil' do
       expect{Taric.client(region: :na, api_key:nil)}.to raise_error(ArgumentError)
     end

     it 'raises when region is nil' do
       expect{Taric.client(region: nil, api_key:'sdsdsdsds')}.to raise_error(ArgumentError)
     end

     it 'raises when region is invalid' do
       expect{Taric.client(region: :not_a_region, api_key:'yay')}.to raise_error(ArgumentError)
     end
  end
end
