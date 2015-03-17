require 'spec_helper'

describe Taric::Operation::LolStatus do
  let(:client) {Taric.client}

  describe '#shards' do
    let (:url) {expand_template(Taric::Operation::LolStatus::SHARDS)}
    before {stub_get(url).to_return(body: fixture('shards.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.shards
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      shards = client.shards
      expect(shards).to be_an Array
      expect(shards.first['name']).to eq('North America')
    end
  end

  describe '#shard' do
    let (:url) {expand_template(Taric::Operation::LolStatus::SHARD, region: 'na')}
    before {stub_get(url).to_return(body: fixture('shard.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.shard(region: 'na')
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      shard = client.shard(region: 'na')
      expect(shard).to be_a Hash
      expect(shard['name']).to eq('North America')
    end
  end
end