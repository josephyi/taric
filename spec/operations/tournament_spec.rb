describe Taric::Operation::Tournament do
  let(:client) {Taric.client(api_key:'test')}
  let(:provider_id) { 289 }
  let(:tournament_name) { 'test tournament name' }
  let(:tournament_id) { 6777 }
  let(:tournament_code) { 'NA041b6-7b158b84-0239-4210-bb7a-b03a474e5bef' }

  describe "#create_provider" do
    let(:region){ "NA" }
    let(:body) { Oj.dump({"region" => "#{region}", "url" => "http://yourcallbackurl.com"}) }
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::PROVIDER_URL)) }

    before {stub_post(url).to_return(body: '289')}

    it 'requests the correct resource' do
      client.create_provider(region: region, url: 'http://yourcallbackurl.com')
      expect(a_post(url).with(body: body, headers: {'X-Riot-Token' => 'test', 'Content-Type' => 'application/json'})).to have_been_made
    end
  end

  describe "#create_tournament" do
    let(:name){ 'test name'}
    let(:body){ Oj.dump({'name' => tournament_name, 'providerId' => provider_id})}
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::TOURNAMENT_URL)) }

    before {stub_post(url).to_return(body: "#{tournament_id}")}

    it 'requests the correct resource' do
      client.create_tournament(name: tournament_name, provider_id: provider_id)
      expect(a_post(url).with(body: body, headers: {'X-Riot-Token' => 'test', 'Content-Type' => 'application/json'})).to have_been_made
    end
  end

  describe "#create_tournament_codes" do
    let(:body) { Oj.dump({'mapType' => 'SUMMONERS_RIFT', 'teamSize' => 5, 'pickType' => 'BLIND_PICK', 'spectatorType' => 'ALL'}) }
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::CODE_URL), {tournamentId: tournament_id, count: 2}) }

    before {stub_post(url).to_return(body: '["NA041b6-8c0f4999-7fe7-428e-93c1-a682ee22cb4f","NA041b6-7ed774e4-9e9e-4e9b-ad7c-27e5eeac4679"]')}
    it 'requests the correct resource' do
      client.create_tournament_codes(tournament_id: tournament_id, count: 2, map_type: 'SUMMONERS_RIFT', pick_type: 'BLIND_PICK', spectator_type: 'ALL', team_size: 5)
      expect(a_post(url).with(body: body, headers: {'X-Riot-Token' => 'test', 'Content-Type' => 'application/json'})).to have_been_made
    end
  end

  describe "#tournament_by_code" do
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::TOURNAMENT_BY_CODE_URL), {tournamentCode: tournament_code}) }

    before {stub_get_json(url, 'tournament_by_code.json')}

    it 'requests the correct resource' do
      client.tournament_by_code(tournament_code: tournament_code)
      expect(a_get(url).with(headers: {'X-Riot-Token' => 'test'})).to have_been_made
    end
  end

  describe "#lobby_events_by_code" do
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::LOBBY_EVENTS_BY_CODE_URL), {tournamentCode: tournament_code}) }

    before {stub_get_json(url, 'lobby_events.json')}

    it 'requests the correct resource' do
      client.lobby_events_by_code(tournament_code: tournament_code)
      expect(a_get(url).with(headers: {'X-Riot-Token' => 'test'})).to have_been_made
    end
  end

  describe "#update_tournament" do
    let(:body){ Oj.dump({'spectatorType' => 'NONE'}) }
    let(:url){ expand_template(Addressable::Template.new(Taric::Operation::Tournament::TOURNAMENT_BY_CODE_URL), {tournamentCode: tournament_code})}

    before {stub_put(url).to_return(status: 204)}

    it 'requests the correct resource' do
      client.update_tournament(tournament_code: tournament_code, spectator_type: 'NONE')
      expect(a_put(url).with(body: body, headers: {'X-Riot-Token' => 'test', 'Content-Type' => 'application/json'})).to have_been_made
    end

  end
end