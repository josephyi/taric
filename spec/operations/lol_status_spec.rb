require 'spec_helper'

describe Taric::Operation::LolStatus do
  let(:client) {Taric.client(api_key:'test')}

  describe '#shard_data' do
    let (:url) {expand_template(Taric::Operation::LolStatus::SHARD.template_url)}
    before {stub_get(url).to_return(body: fixture('shard.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.shard_data
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      shard = client.shard_data.body
      expect(shard).to be_a Hash
      expect(shard['name']).to eq('North America')
    end
  end
end