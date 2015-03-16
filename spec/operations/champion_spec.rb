require 'spec_helper'

describe Taric::Operation::Champion do
  before do
    @client = Taric.client
  end

  describe '#champions' do
    let (:url) {@client.expand_template(Taric::Operation::Champion::CHAMPIONS).to_s}

    it 'expanded template correctly' do
      expect(url).to eq('https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=KeyNotSetButUsingThisForTest')
    end

    context 'with no arguments' do
      before {stub_get(url).to_return(body: fixture('champions.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        @client.champions
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        champions = @client.champions
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
            @client.champions(free_to_play: test)
            expect(a_get(url).with(query:{freeToPlay: "#{test}"})).to have_been_made
          end

          it 'returns the requested result' do
            champions = @client.champions(free_to_play: test)
            expect(champions).to be_a Hash
            expect(champions['champions']).to be_an Array
            expect(champions['champions'].all?{|champion| champion['freeToPlay']}).to eq(test)
          end
        end
      end

    end
  end
end