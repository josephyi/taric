require 'spec_helper'

describe Taric::Operation::Champion do
  let(:client){Taric.client(api_key:'test')}

  describe '#champion-rotations' do
    let (:url) {expand_template(Taric::Operation::Champion::CHAMPION_ROTATIONS.template_url)}
    before {stub_get(url).to_return(body: fixture('champion_rotations.json'), headers: {content_type: 'application/json; charset=utf-8'})}
   
    it 'expanded template correctly' do
      expect(url).to eq('https://na1.api.riotgames.com/lol/platform/v3/champion-rotations')
    end

    it 'requests the correct resource' do
      res = client.champion_rotations.body
      free_to_play = res['freeToPlayChampions']
      expect(a_get(url)).to have_been_made
    end
  end
end