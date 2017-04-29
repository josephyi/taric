describe Taric::Operation::Masteries do
  let(:client) {Taric.client(api_key:'test')}
  let(:id) {'21066'}

  describe '#masteries' do
    let (:url) {expand_template(Taric::Operation::Masteries::MASTERIES.template_url, summonerId: id)}
    before {stub_get(url).to_return(body: fixture('masteries-v3.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.masteries(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      masteries = client.masteries(summoner_id: id).body
      expect(masteries).to be_a Hash
      expect(masteries['pages']).to be_an Array
    end
  end
end