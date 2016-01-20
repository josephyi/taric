require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Summoner
      include Taric::Operation::Base
      
      VERSION = 'v1.4'
      BASE_SUMMONER_URL = "#{BASE_URL_FN.(VERSION)}/summoner"
      BASE_SUMMONERS_BY_IDS = "#{BASE_SUMMONER_URL}/{summonerIds}"

      SUMMONERS_BY_NAMES =   EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/by-name/{summonerNames}{?api_key}")
      SUMMONERS_BY_IDS =  EndpointTemplate.new(template_url: "#{BASE_SUMMONERS_BY_IDS}{?api_key}")
      MASTERIES =  EndpointTemplate.new(template_url: "#{BASE_SUMMONERS_BY_IDS}/masteries{?api_key}")
      NAMES =  EndpointTemplate.new(template_url: "#{BASE_SUMMONERS_BY_IDS}/name{?api_key}")
      RUNES =  EndpointTemplate.new(template_url: "#{BASE_SUMMONERS_BY_IDS}/runes{?api_key}")

      # Returns [Hash] of summoner data hashes keyed by summoner name
      #
      # @see https://developer.riotgames.com/api/methods#!/960/3292
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
      # @see https://developer.riotgames.com/api/methods#!/960/3293
      # @param summoner_ids [String] required, summoner IDs separated by commas
      # @return [Hash] of summoner data hashes keyed by summoner ID
      #
      # @example
      #   summoners = client.summoners_by_id(summoner_ids: '39497114,35035046,38332778,21066,38877656')
      #   summoner = summoners['21066']
      def summoners_by_ids(summoner_ids:)
        response_for SUMMONERS_BY_IDS, {summonerIds: summoner_ids}
      end

      # Masteries keyed by summoner ID.
      #
      # @param summoner_ids [String] comma separated list of Summoner IDs
      # @return [Hash] masteries by Summoner ID
      def summoner_masteries(summoner_ids:)
        response_for MASTERIES, {summonerIds: summoner_ids}
      end

      # Summoner names keyed by ID.
      #
      # @param summoner_ids [String] comma separated list of Summoner IDs
      # @return [Hash] id to name mapping
      def summoner_ids_to_names(summoner_ids:)
        response_for NAMES, {summonerIds: summoner_ids}
      end

      # Runes keyed by summoner ID.
      #
      # @param summoner_ids [String] comma separated list of Summoner IDs
      # @return [Hash] runes by Summoner ID
      def summoner_runes(summoner_ids:)
        response_for RUNES, {summonerIds: summoner_ids}
      end

    end
  end
end
