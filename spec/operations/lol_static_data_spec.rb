require 'spec_helper'

describe Taric::Operation::LolStaticData do
  let(:client) {Taric.client(api_key:'test')}

  describe '#static_champions' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_CHAMPIONS.template_url)}
    before {stub_get_json(url, 'static_champions.json')}

    it 'requests the correct resource' do
      client.static_champions
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      static_champions = client.static_champions.body
      expect(static_champions).to be_a Hash
      expect(static_champions['data']).to be_a Hash
      expect(static_champions['data']['Taric']).to be_a Hash
    end
  end

  describe '#static_champion' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_CHAMPION.template_url, {id: 44})}
    before {stub_get_json(url, 'static_champion.json')}

    it 'requests the correct resource' do
      client.static_champion(id: 44)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      static_champion = client.static_champion(id: 44).body
      expect(static_champion).to be_a Hash
      expect(static_champion['key']).to eq('Taric')
    end
  end

  describe '#static_items' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_ITEMS.template_url)}
    before {stub_get_json(url, 'static_items.json')}

    it 'requests the correct resource' do
      client.static_items
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_items.body
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
      expect(result['data']['2049']).to be_a Hash
    end
  end

  describe '#static_item' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_ITEM.template_url, {id: 2049})}
    before {stub_get_json(url, 'static_item.json')}

    it 'requests the correct resource' do
      client.static_item(id: 2049)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_item(id: 2049).body
      expect(result).to be_a Hash
      expect(result['name']).to eq('Sightstone')
    end
  end

  describe '#static_language_strings' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_LANGUAGE_STRINGS.template_url)}
    before {stub_get_json(url, 'static_language_strings.json')}

    it 'requests the correct resource' do
      client.static_language_strings
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_language_strings.body
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
    end
  end

  describe '#static_languages' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_LANGUAGES.template_url)}
    before {stub_get_json(url, 'static_languages.json')}

    it 'requests the correct resource' do
      client.static_languages
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_languages.body
      expect(result).to be_an Array
      expect(result.first).to be_a String
    end
  end

  describe '#static_masteries' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_MASTERIES.template_url)}
    before {stub_get_json(url, 'static_masteries.json')}

    it 'requests the correct resource' do
      client.static_masteries
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_masteries.body
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
    end
  end

  describe '#static_mastery' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_MASTERY.template_url, {id: 4233})}
    before {stub_get_json(url, 'static_mastery.json')}

    it 'requests the correct resource' do
      client.static_mastery(id: 4233)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_mastery(id: 4233).body
      expect(result).to be_a Hash
      expect(result['name']).to eq('Hardiness')
    end
  end

  describe '#static_map' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_MAP.template_url)}
    before {stub_get_json(url, 'static_map.json')}

    it 'requests the correct resource' do
      client.static_map
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_map.body
      expect(result).to be_a Hash
    end
  end

  describe '#static_realm' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_REALM.template_url)}
    before {stub_get_json(url, 'static_realm.json')}

    it 'requests the correct resource' do
      client.static_realm
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_realm.body
      expect(result).to be_a Hash
      expect(result['n']).to be_a Hash
    end
  end

  describe '#static_runes' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_RUNES.template_url)}
    before {stub_get_json(url, 'static_runes.json')}

    it 'requests the correct resource' do
      client.static_runes
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_runes.body
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
    end
  end

  describe '#static_rune' do
    let (:id) {5235}
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_RUNE.template_url, {id: id})}
    before {stub_get_json(url, 'static_rune.json')}

    it 'requests the correct resource' do
      client.static_rune(id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_rune(id: id).body
      expect(result).to be_a Hash
      expect(result['id']).to eq(id)
    end
  end

  describe '#static_summoner_spells' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_SUMMONER_SPELLS.template_url)}
    before {stub_get_json(url, 'static_summoner_spells.json')}

    it 'requests the correct resource' do
      client.static_summoner_spells
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_summoner_spells.body
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
    end
  end

  describe '#static_summoner_spell' do
    let (:id) {12}
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_SUMMONER_SPELL.template_url, {id: id})}
    before {stub_get_json(url, 'static_summoner_spell.json')}

    it 'requests the correct resource' do
      client.static_summoner_spell(id: id)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_summoner_spell(id: id).body
      expect(result).to be_a Hash
      expect(result['id']).to eq(id)
    end
  end

  describe '#static_versions' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_VERSIONS.template_url)}
    before {stub_get_json(url, 'static_versions.json')}

    it 'requests the correct resource' do
      client.static_versions
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_versions.body
      expect(result).to be_an Array
      expect(result.first).to be_a String
    end
  end


end