require_relative 'base'
module Taric
  module Operation
    module LolStaticData
      include Taric::Operation::Base
      VERSION = 'v1.2'
      BASE_STATIC_URL = "https://global.api.pvp.net/api/lol/static-data/{region}/#{VERSION}"

      STATIC_CHAMPIONS = Addressable::Template.new "#{BASE_STATIC_URL}/champion{?api_key}"
      STATIC_CHAMPION = Addressable::Template.new "#{STATIC_CHAMPIONS}/{id}{?api_key}"
      STATIC_ITEMS = Addressable::Template.new "#{BASE_STATIC_URL}/item{?api_key}"
      STATIC_ITEM = Addressable::Template.new "#{STATIC_ITEMS}/{id}{?api_key}"
      STATIC_LANGUAGE_STRINGS = Addressable::Template.new "#{BASE_STATIC_URL}/language-strings{?api_key}"
      STATIC_LANGUAGES = Addressable::Template.new "#{BASE_STATIC_URL}/languages{?api_key}"
      STATIC_MAP = Addressable::Template.new "#{BASE_STATIC_URL}/map{?api_key}"
      STATIC_MASTERIES = Addressable::Template.new "#{BASE_STATIC_URL}/mastery{?api_key}"
      STATIC_MASTERY = Addressable::Template.new "#{STATIC_MASTERIES}/{id}{?api_key}"
      STATIC_REALM = Addressable::Template.new "#{BASE_STATIC_URL}/realm{?api_key}"
      STATIC_RUNES = Addressable::Template.new "#{BASE_STATIC_URL}/rune{?api_key}"
      STATIC_RUNE = Addressable::Template.new "#{STATIC_RUNES}/{id}{?api_key}"
      STATIC_SUMMONER_SPELLS = Addressable::Template.new "#{BASE_STATIC_URL}/summoner-spell{?api_key}"
      STATIC_SUMMONER_SPELL = Addressable::Template.new "#{STATIC_SUMMONER_SPELLS}/{id}{?api_key}"
      STATIC_VERSIONS = Addressable::Template.new "#{BASE_STATIC_URL}/versions{?api_key}"

      CHAMP_DATA_OPTIONS = [
          'all'.freeze,
          'allytips'.freeze,
          'altimages'.freeze,
          'blurb'.freeze,
          'enemytips'.freeze,
          'image'.freeze,
          'info'.freeze,
          'lore'.freeze,
          'partype'.freeze,
          'passive'.freeze,
          'recommended'.freeze,
          'skins'.freeze,
          'stats'.freeze,
          'tags'.freeze
      ]

      ITEM_DATA_OPTIONS = [
          'all'.freeze,
          'colloq'.freeze,
          'consumeOnFull'.freeze,
          'consumed'.freeze,
          'depth'.freeze,
          'from'.freeze,
          'gold'.freeze,
          'groups'.freeze,
          'hideFromAll'.freeze,
          'image'.freeze,
          'inStore'.freeze,
          'into'.freeze,
          'maps'.freeze,
          'requiredChampion'.freeze,
          'sanitizedDescription'.freeze,
          'specialRecipe'.freeze,
          'stacks'.freeze,
          'stats'.freeze,
          'tags'.freeze,
          'tree'.freeze
      ].freeze

      MASTERY_DATA_OPTIONS = [
          'all'.freeze,
          'image'.freeze,
          'masteryTree'.freeze,
          'prereq'.freeze,
          'ranks'.freeze,
          'sanitizedDescription'.freeze
      ].freeze

      SPELL_DATA_OPTIONS = [
          'all'.freeze,
          'cooldown'.freeze,
          'cooldownBurn'.freeze,
          'cost'.freeze,
          'costType'.freeze,
          'effect'.freeze,
          'effectBurn'.freeze,
          'image'.freeze,
          'key'.freeze,
          'leveltip'.freeze,
          'maxrank'.freeze,
          'modes'.freeze,
          'range'.freeze,
          'rangeBurn'.freeze,
          'resource'.freeze,
          'sanitizedDescription'.freeze,
          'sanitizedTooltip'.freeze,
          'tooltip'.freeze,
          'vars'.freeze
      ].freeze

      def static_champions(data_by_id: nil, champ_data_option: nil, locale: nil, version: nil)
        response_for STATIC_CHAMPIONS, {dataById: data_by_id, champData: champ_data_option, locale: locale, version: version}
      end

      def static_champion(id:, champ_data_option: nil, locale: nil, version: nil)
        response_for STATIC_CHAMPION, {id: id, champData: champ_data_option, locale: locale, version: version}
      end

      def static_items(item_data_option: nil, locale: nil, version: nil)
        response_for STATIC_ITEMS, {itemListData: item_data_option, locale: locale, version: version,}
      end

      def static_item(id:, item_data_option: nil, locale: nil, version: nil)
        response_for STATIC_ITEM, {id: id, itemData: item_data_option, locale: locale, version: version}
      end

      def static_language_strings(locale: nil, version: nil)
        response_for STATIC_LANGUAGE_STRINGS, {locale: locale, version: version}
      end

      def static_languages
        response_for STATIC_LANGUAGES
      end

      def static_map(locale: nil, version: nil)
        response_for STATIC_MAP, {locale: locale, version: version}
      end

      def static_masteries(mastery_data_option: nil, locale: nil, version: nil)
        response_for STATIC_MASTERIES, {masteryListData: mastery_data_option, locale: locale, version: version}
      end

      def static_mastery(id:, mastery_data_option: nil, locale: nil, version: nil)
        response_for STATIC_MASTERY, {id: id, masteryData: mastery_data_option, locale:locale, version: version}
      end

      def static_realm
        response_for STATIC_REALM
      end

      def static_runes(rune_data_option: nil, locale: nil, version: nil)
        response_for STATIC_RUNES, {runeListData: rune_data_option, locale: locale, version: version}
      end

      def static_rune(id:, rune_data_option: nil, locale: nil, version: nil)
        response_for STATIC_RUNE, {id: id, runeData: rune_data_option, locale: locale, version: version}
      end

      def static_summoner_spells(data_by_id: nil, spell_data_option: nil, locale: nil, version: nil)
        response_for STATIC_SUMMONER_SPELLS, {dataById: data_by_id, spellData: spell_data_option, locale: locale, version: version}
      end

      def static_summoner_spell(id:, spell_data_option: nil, locale: nil, version: nil)
        response_for STATIC_SUMMONER_SPELL, {id: id, spellData: spell_data_option, locale: locale, version: version}
      end

      def static_versions
        response_for STATIC_VERSIONS
      end
    end
  end
end