require 'spec_helper'

describe Taric::Operation::Game do
  let(:client) {Taric.client(api_key:'test')}

  describe '#recent_games' do
    let (:url) {expand_template(Taric::Operation::Game::RECENT, {summonerId: 21066})}

    before {stub_get(url).to_return(body: fixture('recent_games.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.recent_games(summoner_id: 21066)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      recent_games = client.recent_games(summoner_id: 21066).body
      expect(recent_games).to be_a Hash
      expect(recent_games['games']).to be_an Array
      expect(recent_games['summonerId']).to eq(21066)
    end
  end
end