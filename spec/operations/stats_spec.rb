require 'spec_helper'

describe Taric::Operation::Stats do
  let(:client) {Taric.client(api_key:'test')}

  describe '#ranked_stats' do
    let(:id) {21066}
    let(:url) {expand_template(Taric::Operation::Stats::RANKED.template_url, {summonerId: 21066})}

    before {stub_get(url).to_return(body: fixture('ranked_stats.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.ranked_stats(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.ranked_stats(summoner_id: id).body
      expect(result).to be_a Hash
      expect(result['summonerId']).to eq(id)
    end
  end

  describe '#summary_stats' do
    let(:id) {21066}
    let(:url) {expand_template(Taric::Operation::Stats::SUMMARY.template_url, {summonerId: 21066})}

    before {stub_get(url).to_return(body: fixture('summary_stats.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summary_stats(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summary_stats(summoner_id: id).body
      expect(result).to be_a Hash
      expect(result['summonerId']).to eq(id)
    end
  end
end