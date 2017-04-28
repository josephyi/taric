require 'spec_helper'

describe Taric::Operation::Summoner do
  let(:client) {Taric.client(api_key:'test')}
  let(:id) {'21066'}
  let(:account_id) {'47910'}
  let(:ids) {'21066'}

  describe '#summoner_by_account_id' do
    let(:url) {expand_template(Taric::Operation::Summoner::SUMMONER_BY_ACCOUNT_ID.template_url, {accountId: account_id})}

    before {stub_get(url).to_return(body: fixture('summoner.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_by_account_id(account_id: account_id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_by_account_id(account_id: account_id).body
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_by_name' do
    let(:name) {'orlyzomg'}
    let(:url) {expand_template(Taric::Operation::Summoner::SUMMONER_BY_NAME.template_url, {summonerName: name})}

    before {stub_get(url).to_return(body: fixture('summoner.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_by_name(summoner_name: name)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_by_name(summoner_name: name).body
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_by_id' do
    let(:url) {expand_template(Taric::Operation::Summoner::SUMMONER_BY_ID.template_url, {summonerId: id})}

    before {stub_get(url).to_return(body: fixture('summoner.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_by_id(summoner_id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_by_id(summoner_id: id).body
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_masteries' do
    let(:url) {expand_template(Taric::Operation::Summoner::MASTERIES.template_url, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoner_masteries.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_masteries(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_masteries(summoner_ids: ids).body
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_runes' do
    let(:url) {expand_template(Taric::Operation::Summoner::RUNES.template_url, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoner_runes.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_runes(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_runes(summoner_ids: ids).body
      expect(result).to be_a Hash
    end
  end

end