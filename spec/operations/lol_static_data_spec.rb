require 'spec_helper'

describe Taric::Operation::LolStaticData do
  let(:client) {Taric.client}

  describe '#static_champions' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_CHAMPIONS)}
    before {stub_get_json(url, 'static_champions.json')}

    it 'requests the correct resource' do
      client.static_champions
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      static_champions = client.static_champions
      expect(static_champions).to be_a Hash
      expect(static_champions['data']).to be_a Hash
      expect(static_champions['data']['Taric']).to be_a Hash
    end
  end

  describe '#static_champion' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_CHAMPION, {id: 44})}
    before {stub_get_json(url, 'static_champion.json')}

    it 'requests the correct resource' do
      client.static_champion(id: 44)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      static_champion = client.static_champion(id: 44)
      expect(static_champion).to be_a Hash
      expect(static_champion['key']).to eq('Taric')
    end
  end

  describe '#static_items' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_ITEMS)}
    before {stub_get_json(url, 'static_items.json')}

    it 'requests the correct resource' do
      client.static_items
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_items
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
      expect(result['data']['2049']).to be_a Hash
    end
  end

  describe '#static_item' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_ITEM, {id: 2049})}
    before {stub_get_json(url, 'static_item.json')}

    it 'requests the correct resource' do
      client.static_item(id: 2049)
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_item(id: 2049)
      expect(result).to be_a Hash
      expect(result['name']).to eq('Sightstone')
    end
  end

  describe '#static_language_strings' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_LANGUAGE_STRINGS)}
    before {stub_get_json(url, 'static_language_strings.json')}

    it 'requests the correct resource' do
      client.static_language_strings
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_language_strings
      expect(result).to be_a Hash
      expect(result['data']).to be_a Hash
    end
  end

  describe '#static_languages' do
    let (:url) {expand_template(Taric::Operation::LolStaticData::STATIC_LANGUAGES)}
    before {stub_get_json(url, 'static_languages.json')}

    it 'requests the correct resource' do
      client.static_languages
      expect(a_get(url)).to have_been_made
    end

    it 'returns the requested result' do
      result = client.static_languages
      expect(result).to be_an Array
      expect(result.first).to be_a String
    end
  end
end