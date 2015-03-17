require 'spec_helper'

describe Taric::Operation::FeaturedGames do
  let(:client) {Taric.client}

  describe '#featured_games' do
    let (:url) {client.expand_template(Taric::Operation::FeaturedGames::FEATURED_GAMES).to_s}

    before {stub_get(url).to_return(body: fixture('featured_games.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.featured_games
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      featured_games = client.featured_games
      expect(featured_games).to be_a Hash
      expect(featured_games['gameList']).to be_an Array
      expect(featured_games['gameList'].first).to be_a Hash
    end
  end
end