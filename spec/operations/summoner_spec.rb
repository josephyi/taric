require 'spec_helper'

describe Taric::Operation::Summoner do
  let(:client) {Taric.client(api_key:'test')}
  let(:ids) {'35035046,39497114,38332778,38877656,21066'}

  describe '#summoners_by_names' do
    let(:names) {'orlyzomg,ipa,doodiediddle,lzrface,dbanksdesign'}
    let(:url) {expand_template(Taric::Operation::Summoner::SUMMONERS_BY_NAMES, {summonerNames: names})}

    before {stub_get(url).to_return(body: fixture('summoners_by_names.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoners_by_names(summoner_names: names)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoners_by_names(summoner_names: names)
      expect(result).to be_a Hash
    end
  end

  describe '#summoners_by_ids' do
    let(:url) {expand_template(Taric::Operation::Summoner::SUMMONERS_BY_IDS, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoners_by_ids.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoners_by_ids(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoners_by_ids(summoner_ids: ids)
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_masteries' do
    let(:url) {expand_template(Taric::Operation::Summoner::MASTERIES, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoner_masteries.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_masteries(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_masteries(summoner_ids: ids)
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_runes' do
    let(:url) {expand_template(Taric::Operation::Summoner::RUNES, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoner_runes.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_runes(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_runes(summoner_ids: ids)
      expect(result).to be_a Hash
    end
  end

  describe '#summoner_ids_to_names' do
    let(:url) {expand_template(Taric::Operation::Summoner::NAMES, {summonerIds: ids})}

    before {stub_get(url).to_return(body: fixture('summoner_ids_to_names.json'), headers: {content_type: 'application/json; charset=utf-8'})}

    it 'requests the correct resource' do
      client.summoner_ids_to_names(summoner_ids: ids)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.summoner_ids_to_names(summoner_ids: ids)
      expect(result).to be_a Hash
    end
  end
end