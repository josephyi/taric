require 'spec_helper'

describe Taric::Operation::FeaturedGames do
  let(:client) {Taric.client(api_key:'test')}

  describe '#api_challenge_match_ids' do
    let (:url) {expand_template(Taric::Operation::ApiChallenge::API_CHALLENGE_MATCH_IDS)}

    test_time = 1427866800
    before {stub_get(url).with(query:{beginDate: test_time}).to_return(body: fixture("api_challenge.json"), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.api_challenge_match_ids(begin_date: test_time)
      expect(a_get(url).with(query:{beginDate: test_time})).to have_been_made
    end

    it 'returns the requested result' do
      match_ids = client.api_challenge_match_ids(begin_date: test_time)
      expect(match_ids).to be_an Array
    end
  end
end