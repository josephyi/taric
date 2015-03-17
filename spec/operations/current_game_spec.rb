require 'spec_helper'

describe Taric::Operation::CurrentGame do
  let(:client) {Taric.client}

  describe '#current_game' do
    let (:url) {expand_template(Taric::Operation::CurrentGame::GAME_INFO, {summonerId: 37480768})}

    before {stub_get(url).to_return(body: fixture('current_game.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.current_game(summoner_id: 37480768)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      current_game = client.current_game(summoner_id: 37480768)
      expect(current_game).to be_a Hash
      expect(current_game['participants']).to be_an Array
      expect(current_game['gameId']).to eq(1763258300)
    end
  end
end