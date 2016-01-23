describe Taric::Operation::ChampionMastery do
  let(:client){Taric.client(api_key:'test')}
  let(:summoner_id) { 21066 }
  let(:champion_id) { 12 }

  describe '#champion_mastery' do
    let(:url) {expand_template(Taric::Operation::ChampionMastery::MASTERY_BY_CHAMPION_ID.template_url, {championId: champion_id, summonerId: summoner_id})}

    before{ stub_get_json(url, 'champion_mastery.json') }

    it 'requests the correct resource' do
      client.champion_mastery(summoner_id: summoner_id, champion_id: champion_id)
      expect(a_get(url)).to have_been_made
    end
  end

  describe '#champion_mastery_all' do
    let(:url) {expand_template(Taric::Operation::ChampionMastery::MASTERY_ALL_CHAMPIONS.template_url, {summonerId: summoner_id})}

    before{ stub_get_json(url, 'champion_mastery_all.json') }

    it 'requests the correct resource' do
      client.champion_mastery_all(summoner_id: summoner_id)
      expect(a_get(url)).to have_been_made
    end
  end

  describe '#champion_mastery_score' do
    let(:url) {expand_template(Taric::Operation::ChampionMastery::MASTERY_SCORE.template_url, {summonerId: summoner_id})}

    before {stub_get(url).to_return(body: '59', headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.champion_mastery_score(summoner_id: summoner_id)
      expect(a_get(url)).to have_been_made
    end
  end

  describe '#top_champions' do
    let(:url) {expand_template(Taric::Operation::ChampionMastery::MASTERY_TOP_CHAMPIONS.template_url, {summonerId: summoner_id, count: 3})}

    before{ stub_get_json(url, 'champion_mastery_top.json') }

    it 'requests the correct resource' do
      client.top_champions(summoner_id: summoner_id)
      expect(a_get(url)).to have_been_made
    end
  end
end