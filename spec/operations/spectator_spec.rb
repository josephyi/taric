describe Taric::Operation::Spectator do
  let(:client) {Taric.client(api_key:'test')}

  describe '#current_game' do
    let (:url) {expand_template(Taric::Operation::Spectator::CURRENT_GAME_V3.template_url, {summonerId: 37480768})}

    before {stub_get(url).to_return(body: fixture('current_game.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.current_game(summoner_id: 37480768)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      current_game = client.current_game(summoner_id: 37480768).body
      expect(current_game).to be_a Hash
      expect(current_game['participants']).to be_an Array
      expect(current_game['gameId']).to eq(2488107717)
    end
  end

  describe '#featured_games' do
    let (:url) {expand_template(Taric::Operation::Spectator::FEATURED_GAMES_V3.template_url)}

    before {stub_get_json(url, 'featured_games.json')}

    it 'requests the correct resource' do
      client.featured_games
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      featured_games = client.featured_games.body
      expect(featured_games).to be_a Hash
      expect(featured_games['gameList']).to be_an Array
      expect(featured_games['gameList'].first).to be_a Hash
    end
  end
end