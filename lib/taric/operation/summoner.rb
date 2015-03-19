require_relative 'base'
module Taric
  module Operation
    module Summoner
      include Taric::Operation::Base
      
      VERSION = 'v1.4'
      BASE_SUMMONER_URL = "#{BASE_URL_FN.(VERSION)}/summoner"
      BASE_SUMMONERS_BY_IDS = "#{BASE_SUMMONER_URL}/{summonerIds}"

      SUMMONERS_BY_NAMES =  Addressable::Template.new "#{BASE_SUMMONER_URL}/by-name/{summonerNames}{?api_key}"
      SUMMONERS_BY_IDS = Addressable::Template.new "#{BASE_SUMMONERS_BY_IDS}{?api_key}"
      MASTERIES = Addressable::Template.new "#{BASE_SUMMONERS_BY_IDS}/masteries{?api_key}"
      NAMES = Addressable::Template.new "#{BASE_SUMMONERS_BY_IDS}/name{?api_key}"
      RUNES = Addressable::Template.new "#{BASE_SUMMONERS_BY_IDS}/runes{?api_key}"

      # Returns [Hash] of summoner data hashes keyed by summoner name
      #
      # @see {https://developer.riotgames.com/api/methods#!/960/3292}
      # @param summoner_names [String] required, summoner names separated by commas
      # @return [Hash] of summoner data hashes keyed by summoner name
      #
      # @example
      #   summoners = client.summoners_by_name(summoner_names: 'orlyzomg,ipa,dbanksdesign,lzrface,doodiediddle')
      #   summoner = summoners['orlyzomg']
      def summoners_by_names(summoner_names:)
        response_for SUMMONERS_BY_NAMES, {summonerNames: summoner_names}
      end

      # Returns [Hash] of summoner data hashes keyed by summoner ID
      #
      # @see {https://developer.riotgames.com/api/methods#!/960/3293}
      # @param summoner_ids [String] required, summoner IDs separated by commas
      # @return [Hash] of summoner data hashes keyed by summoner ID
      #
      # @example
      #   summoners = client.summoners_by_id(summoner_ids: '39497114,35035046,38332778,21066,38877656')
      #   summoner = summoners['21066']
      def summoners_by_ids(summoner_ids:)
        response_for SUMMONERS_BY_IDS, {summonerIds: summoner_ids}
      end

      def summoner_masteries(summoner_ids:)
        response_for MASTERIES, {summonerIds: summoner_ids}
      end

      def summoner_ids_to_names(summoner_ids:)
        response_for NAMES, {summonerIds: summoner_ids}
      end

      def summoner_runes(summoner_ids:)
        response_for RUNES, {summonerIds: summoner_ids}
      end

    end
  end
end