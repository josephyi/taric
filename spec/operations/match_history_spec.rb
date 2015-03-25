require 'spec_helper'

describe Taric::Operation::MatchHistory do
  let(:client) {Taric.client(api_key:'test')}

  describe '#match_history' do
    let (:id) {21066}
    let (:url) {expand_template(Taric::Operation::MatchHistory::MATCH_HISTORY, {summonerId: id})}

    before {stub_get(url).to_return(body: fixture('match_history.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.match_history(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.match_history(summoner_id: id)
      expect(result).to be_a Hash
      expect(result['matches']).to be_an Array
      expect(result['matches'].first).to be_a Hash
    end
  end
end