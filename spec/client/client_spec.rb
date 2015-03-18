require 'spec_helper'

describe Taric::Client do
  describe '.operation_values' do
    it 'returns a hash with api_key and region' do
      hash = Taric::Client.operation_values(api_key: 'test', region: :na)
      expect(hash[:api_key]).to eq('test')
      expect(hash[:region]).to eq('na')
    end

    it 'returns memoized values' do
      hash = Taric::Client.operation_values(api_key: 'test', region: :na)
      hash2 = Taric::Client.operation_values(api_key: 'test', region: :na)
      expect(hash.object_id).to eq(hash2.object_id)
    end
  end

  describe '.expand_template' do
    it 'returns an expanded Addressable template' do
      template = Taric::Client.expand_template(api_key: 'test', region: :na, operation: Taric::Operation::Champion::CHAMPIONS)
      expect(template).to be_an Addressable::URI
      expect(template.to_s).to eq('https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=test')
    end
  end
end