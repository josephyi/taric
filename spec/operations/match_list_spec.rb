describe Taric::Operation::MatchList do
  let(:client) {Taric.client(api_key:'test')}

  describe '#match_list' do
    let (:id) {21066}
    let (:url) {expand_template(Taric::Operation::MatchList::MATCH_LIST, {summonerId: id})}

    before {stub_get(url).to_return(body: fixture('match_list.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.match_list(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.match_list(summoner_id: id)
      expect(result).to be_a Hash
      expect(result['matches']).to be_an Array
      expect(result['matches'].first).to be_a Hash
    end
  end
end