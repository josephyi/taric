require 'spec_helper'

describe Taric::Operation::Team do
  let(:client) {Taric.client(api_key:'test')}

  describe '#teams_by_summoner_ids' do
    let(:ids) {'21066'}

    let(:url) {expand_template(Taric::Operation::Team::TEAMS_BY_SUMMONER_IDS.template_url, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('teams_by_summoner_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.teams_by_summoner_ids(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.teams_by_summoner_ids(summoner_ids: ids).body
      expect(result).to be_a Hash
      expect(result['21066']).to be_an Array
    end
  end

  describe '#teams' do
    let(:ids) {'TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2'}

    let(:url) {expand_template(Taric::Operation::Team::TEAMS_BY_TEAM_IDS.template_url, {teamIds: ids})}

    before {stub_get(url).to_return(body: fixture('teams_by_team_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.teams(team_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.teams(team_ids: ids).body
      expect(result).to be_a Hash
      expect(result['TEAM-fa073ee0-51ca-11e4-82cc-782bcb4d0bb2']).to be_a Hash
    end
  end
end