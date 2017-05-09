require 'spec_helper'

describe Taric::Operation::League do
  let(:client) {Taric.client(api_key:'test')}
  let(:ids) {'21066'}

  describe '#leagues' do
    let(:url) {expand_template(Taric::Operation::League::LEAGUES_BY_SUMMONER_ID.template_url, {summonerId: ids})}

    before {stub_get(url).to_return(body: fixture('leagues_by_summoner_id.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.leagues(summoner_id: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.leagues(summoner_id: ids).body
      expect(result).to be_a Array
      expect(result.first['queue']).to be_a String
    end
  end

  describe '#league_positions' do
    let(:url) {expand_template(Taric::Operation::League::POSITION_BY_SUMMONER_ID.template_url, {summonerId: ids})}

    before {stub_get(url).to_return(body: fixture('league_positions.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.league_positions(summoner_id: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.league_positions(summoner_id: ids).body
      expect(result).to be_a Array
      expect(result.first['queueType']).to be_a String
    end
  end

  describe '#challenger_leagues' do
    context 'solo queue' do
      let(:queue) {'RANKED_SOLO_5x5'}
      let(:url) {expand_template(Taric::Operation::League::CHALLENGER.template_url, {queue: queue})}

      before {stub_get(url).to_return(body: fixture('challenger_solo_queue.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        client.challenger_leagues(queue: queue)
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        result = client.challenger_leagues(queue: queue).body
        expect(result).to be_a Hash
        expect(result['queue']).to eq('RANKED_SOLO_5x5')
        expect(result['entries']).to be_an Array
      end
    end
  end

  describe '#master_leagues' do
    context 'solo queue' do
      let(:queue) {'RANKED_SOLO_5x5'}
      let(:url) {expand_template(Taric::Operation::League::MASTER.template_url, {queue: queue})}

      before {stub_get(url).to_return(body: fixture('master_solo_queue.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        client.master_leagues(queue: queue)
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        result = client.master_leagues(queue: queue).body
        expect(result).to be_a Hash
        expect(result['queue']).to eq('RANKED_SOLO_5x5')
        expect(result['entries']).to be_an Array
      end
    end
  end

end