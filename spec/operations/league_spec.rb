require 'spec_helper'

describe Taric::Operation::League do
  let(:client) {Taric.client(api_key:'test')}
  let(:ids) {'21066,38877656,35035046'}

  describe '#leagues_by_summoner_ids' do
    let(:url) {expand_template(Taric::Operation::League::LEAGUES_BY_SUMMONER_IDS, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('leagues_by_summoner_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.leagues_by_summoner_ids(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.leagues_by_summoner_ids(summoner_ids: ids).body
      expect(result).to be_a Hash
      expect(result['21066']).to be_an Array
      expect(result['38877656']).to be_an Array
      expect(result['35035046']).to be_nil
    end
  end

  describe '#league_entries_by_summoner_ids' do
    let(:url) {expand_template(Taric::Operation::League::ENTRIES_BY_SUMMONER_IDS, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('league_entries_by_summoner_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.league_entries_by_summoner_ids(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.league_entries_by_summoner_ids(summoner_ids: ids).body
      expect(result).to be_a Hash
      expect(result['21066']).to be_an Array
      expect(result['38877656']).to be_an Array
      expect(result['35035046']).to be_nil
    end
  end

  describe '#leagues_by_team_ids' do
    let(:ids) {'TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2'}

    let(:url) {expand_template(Taric::Operation::League::LEAGUES_BY_TEAM_IDS, {teamIds: ids})}

    before {stub_get(url).to_return(body: fixture('leagues_by_team_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.leagues_by_team_ids(team_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.leagues_by_team_ids(team_ids: ids).body
      expect(result).to be_a Hash
      expect(result['TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2']).to be_an Array
    end
  end

  describe '#league_entries_by_team_ids' do
    let(:ids) {'TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2'}

    let(:url) {expand_template(Taric::Operation::League::ENTRIES_BY_TEAM_IDS, {teamIds: ids})}

    before {stub_get(url).to_return(body: fixture('league_entries_by_team_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.league_entries_by_team_ids(team_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.league_entries_by_team_ids(team_ids: ids).body
      expect(result).to be_a Hash
      expect(result['TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2']).to be_an Array
    end
  end

  describe '#challenger' do
    context 'solo queue' do
      let(:type) {'RANKED_SOLO_5x5'}
      let(:url) {expand_template(Taric::Operation::League::CHALLENGER, {type: type})}

      before {stub_get(url).to_return(body: fixture('challenger_solo_queue.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        client.challenger(type: type)
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        result = client.challenger(type: type).body
        expect(result).to be_a Hash
        expect(result['queue']).to eq('RANKED_SOLO_5x5')
        expect(result['entries']).to be_an Array
      end
    end

    context 'team queue' do
      let(:type) {'RANKED_TEAM_5x5'}
      let(:url) {expand_template(Taric::Operation::League::CHALLENGER, {type: type})}

      before {stub_get(url).to_return(body: fixture('challenger_team_queue.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        result = client.challenger(type: type).body
        expect(result['queue']).to eq('RANKED_TEAM_5x5')
        expect(result['entries']).to be_an Array
      end
    end
  end

  describe '#master' do
    context 'solo queue' do
      let(:type) {'RANKED_SOLO_5x5'}
      let(:url) {expand_template(Taric::Operation::League::MASTER, {type: type})}

      before {stub_get(url).to_return(body: fixture('master_solo_queue.json'), headers: {content_type: 'application/json; charset=utf-8'})}

      it 'requests the correct resource' do
        client.master(type: type)
        expect(a_get(url)).to have_been_made
      end

      it 'returns the requested result' do
        result = client.master(type: type).body
        expect(result).to be_a Hash
        expect(result['queue']).to eq('RANKED_SOLO_5x5')
        expect(result['entries']).to be_an Array
      end
    end
  end

end