require_relative 'base'
module Taric
  module Operation
    module LolStaticData
      include Taric::Operation::Base
      VERSION = 'v1.2'
      BASE_STATIC_URL = "https://global.api.pvp.net/api/lol/static-data/{region}/#{VERSION}"

      STATIC_CHAMPIONS = Addressable::Template.new "#{BASE_STATIC_URL}/champion{?api_key,dataById,locale,version}"
      STATIC_CHAMPION = Addressable::Template.new "#{BASE_STATIC_URL}/champion/{id}{?api_key,locale,version}"
      STATIC_ITEMS = Addressable::Template.new "#{BASE_STATIC_URL}/item{?api_key,itemListData,locale,version}"
      STATIC_ITEM = Addressable::Template.new "#{BASE_STATIC_URL}/item/{id}{?api_key,itemData,locale,version}"
      STATIC_LANGUAGE_STRINGS = Addressable::Template.new "#{BASE_STATIC_URL}/language-strings{?api_key,locale,version}"
      STATIC_LANGUAGES = Addressable::Template.new "#{BASE_STATIC_URL}/languages{?api_key}"
      STATIC_MAP = Addressable::Template.new "#{BASE_STATIC_URL}/map{?api_key}"
      STATIC_MASTERIES = Addressable::Template.new "#{BASE_STATIC_URL}/mastery{?api_key,masteryListData,locale,version}"
      STATIC_MASTERY = Addressable::Template.new "#{BASE_STATIC_URL}/mastery/{id}{?api_key,masteryData,locale,version}"
      STATIC_REALM = Addressable::Template.new "#{BASE_STATIC_URL}/realm{?api_key}"
      STATIC_RUNES = Addressable::Template.new "#{BASE_STATIC_URL}/rune{?api_key,runeListData,locale,version}"
      STATIC_RUNE = Addressable::Template.new "#{BASE_STATIC_URL}/rune/{id}{?api_key,runeData,locale,version}"
      STATIC_SUMMONER_SPELLS = Addressable::Template.new "#{BASE_STATIC_URL}/summoner-spell{?api_key,spellData,locale,version}"
      STATIC_SUMMONER_SPELL = Addressable::Template.new "#{BASE_STATIC_URL}/summoner-spell/{id}{?api_key,spellData,locale,version}"
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

      # locales mapped to languages
      LOCALE = {
          bg_BG: 'Bulgarian (Bulgaria)',
          cs_CZ: 'Czech (Czech Republic)',
          de_DE: 'German (Germany)',
          el_GR: 'Greek (Greece)',
          en_AU: 'English (Australia)',
          en_GB: 'English (United Kingdom)',
          en_PH: 'English (Republic of the Philippines)',
          en_PL: 'English (Poland)',
          en_SG: 'English (Singapore)',
          en_US: 'English (United States)',
          es_AR: 'Spanish (Argentina)',
          es_ES: 'Spanish (Spain)',
          es_MX: 'Spanish (Mexico)',
          fr_FR: 'French (France)',
          hu_HU: 'Hungarian (Hungary)',
          id_ID: 'Indonesian (Indonesia)',
          it_IT: 'Italian (Italy)',
          ja_JP: 'Japanese (Japan)',
          ko_KR: 'Korean (Korea)',
          nl_NL: 'Dutch (Netherlands)',
          ms_MY: 'Malay (Malaysia)',
          pl_PL: 'Polish (Poland)',
          pt_BR: 'Portuguese (Brazil)',
          pt_PT: 'Portuguese (Portugal)',
          ro_RO: 'Romanian (Romania)',
          ru_RU: 'Russian (Russia)',
          th_TH: 'Thai (Thailand)',
          tr_TR: 'Turkish (Turkey)',
          vn_VN: 'Vietnamese (Viet Nam)',
          zh_CN: 'Chinese (China)',
          zh_MY: 'Chinese (Malaysia)',
          zh_TW: 'Chinese (Taiwan)'
      }

      LOCALE_KEYS = LOCALE.keys

      # Static data for champions
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3326
      # @param data_by_id [Boolean] optional, if true, champion data keyed to IDs
      # @param champ_data_option [String] optional, filter from [CHAMP_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static champion data
      #
      # @example
      #   # Defaults
      #   champions = client.static_champions
      #   # Mapped by IDs
      #   champions = client.static_champions(data_by_id: true)
      def static_champions(data_by_id: nil, champ_data_option: nil, locale: nil, version: nil)
        response_for STATIC_CHAMPIONS, {dataById: data_by_id, champData: champ_data_option, locale: locale, version: version}
      end

      # Static data for champion by id
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3322
      # @param id [Fixnum] id of champion
      # @param champ_data_option [String] optional, filter from [CHAMP_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static champion data
      #
      # @example
      #   champions = client.static_champions(id: 44)
      def static_champion(id:, champ_data_option: nil, locale: nil, version: nil)
        response_for STATIC_CHAMPION, {id: id, champData: champ_data_option, locale: locale, version: version}
      end

      # Static data for items
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3314
      # @param item_data_option [String] optional, filter from [ITEM_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static item data
      #
      # @example
      #   # Defaults
      #   champions = client.static_items
      def static_items(item_data_option: nil, locale: nil, version: nil)
        response_for STATIC_ITEMS, {itemListData: item_data_option, locale: locale, version: version}
      end

      # Static data for item by id
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3319
      # @param id [Fixnum] id of item
      # @param item_data_option [String] optional, filter from [ITEM_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static item data for id
      #
      # @example
      #   item = client.static_item(id: 2049)
      def static_item(id:, item_data_option: nil, locale: nil, version: nil)
        response_for STATIC_ITEM, {id: id, itemData: item_data_option, locale: locale, version: version}
      end

      # Returns [Hash] of language string data.
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3316
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      # @return [Hash] of language string data
      # @example
      #   language_strings = client.static_language_strings
      def static_language_strings(locale: nil, version: nil)
        response_for STATIC_LANGUAGE_STRINGS, {locale: locale, version: version}
      end

      # Returns [Array] of languages.
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3324
      # @return [Array] of languages
      # @example
      #   languages = client.static_languages
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