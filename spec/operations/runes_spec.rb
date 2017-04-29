describe Taric::Operation::Runes do
  let(:client) {Taric.client(api_key:'test')}
  let(:id) {'21066'}

  describe '#runes' do
    let (:url) {expand_template(Taric::Operation::Runes::RUNES_V3.template_url, summonerId: id)}
    before {stub_get(url).to_return(body: fixture('runes-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.runes(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      runes = client.runes(summoner_id: id).body
      expect(runes).to be_a Hash
      expect(runes['pages']).to be_an Array
    end
  end
end