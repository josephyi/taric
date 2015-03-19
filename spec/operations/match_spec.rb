require 'spec_helper'

describe Taric::Operation::Match do
  let(:client) {Taric.client}

  describe '#match' do
    let(:id) {1733750076}
    let(:url) {expand_template(Taric::Operation::Match::MATCH, {matchId: id})}

    before {stub_get(url).to_return(body: fixture('match.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.match(id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.match(id: id)
      expect(result).to be_a Hash
      expect(result['matchId']).to eq(id)
    end
  end
end