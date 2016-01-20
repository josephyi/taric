require 'spec_helper'

describe Taric::Operation::FeaturedGames do
  let(:client) {Taric.client(api_key:'test')}

  describe '#featured_games' do
    let (:url) {expand_template(Taric::Operation::FeaturedGames::FEATURED_GAMES.template_url)}

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