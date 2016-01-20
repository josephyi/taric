require 'spec_helper'

describe Taric::Operation::Champion do
  let(:client){Taric.client(api_key:'test')}

  describe '#champions' do
    let (:url) {expand_template(Taric::Operation::Champion::CHAMPIONS.template_url)}

    it 'expanded template correctly' do
      expect(url).to eq('https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=test')
    end

    context 'with no arguments' do
      before {stub_get(url).to_return(body: fixture('champions.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        client.champions
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        champions = client.champions.body
        expect(champions).to be_a Hash
        expect(champions['champions']).to be_an Array
        expect(champions['champions'].first['id']).to eq(266)
      end
    end

    context 'when free_to_play is set' do
      [true,false].each do |test|
        context "to #{test}" do
          before {stub_get(url).with(query:{freeToPlay: "#{test}"}).to_return(body: fixture("champions-#{test}.json"), headers: {content_type: 'application/json; charset=utf-8'})}

          it 'requests the correct resource' do
            client.champions(free_to_play: test)
            expect(a_get(url).with(query:{freeToPlay: "#{test}"})).to have_been_made
          end

          it 'returns the requested result' do
            champions = client.champions(free_to_play: test).body
            expect(champions).to be_a Hash
            expect(champions['champions']).to be_an Array
            expect(champions['champions'].all?{|champion| champion['freeToPlay']}).to eq(test)
          end
        end
      end
    end
  end
  
  describe '#champion' do
    let (:url) {expand_template(Taric::Operation::Champion::CHAMPION_BY_ID.template_url, {id: 7})}
    before {stub_get(url).to_return(body: fixture('champion.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.champion(id: 7)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      champion = client.champion(id: 7).body
      expect(champion).to be_a Hash
      expect(champion['id']).to eq(7)
    end
  end
end