require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module League
      include Taric::Operation::Base

      LEAGUE_VERSION = 'v2.5'
      BASE_LEAGUE_URL = "#{BASE_URL_FN.(LEAGUE_VERSION)}/league"

      LEAGUES_BY_SUMMONER_IDS = EndpointTemplate.new(template_url: "#{BASE_LEAGUE_URL}/by-summoner/{summonerIds}{?api_key}")
      ENTRIES_BY_SUMMONER_IDS = EndpointTemplate.new(template_url: "#{BASE_LEAGUE_URL}/by-summoner/{summonerIds}/entry{?api_key}")
      CHALLENGER = EndpointTemplate.new(template_url: "#{BASE_LEAGUE_URL}/challenger{?api_key,type}")
      MASTER = EndpointTemplate.new(template_url: "#{BASE_LEAGUE_URL}/master{?api_key,type}")

      CHALLENGER_QUEUE_TYPES = ['RANKED_FLEX_SR'.freeze, 'RANKED_FLEX_TT'.freeze, 'RANKED_SOLO_5x5'.freeze, 'RANKED_TEAM_3x3'.freeze, 'RANKED_TEAM_5x5'.freeze].freeze
      MASTER_QUEUE_TYPES = CHALLENGER_QUEUE_TYPES

      # Leagues by summoner IDs.
      #
      # @see https://developer.riotgames.com/api/methods#!/985/3351
      # @param summoner_ids summoner_ids [String] comma separated list of summoner ids
      # @return [Hash] leagues keyed by summoner ids
      #
      # @example
      #   result = client.leagues_by_summoner_ids(summoner_ids: '21066,38877656')
      #   leagues = result['21066']
      #   entries = first_summoner_leagues.first['entries']
      def leagues_by_summoner_ids(summoner_ids:)
        response_for LEAGUES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      # League entries by summoner IDs.
      #
      # @see https://developer.riotgames.com/api/methods#!/985/3351
      # @param summoner_ids summoner_ids [String] comma separated list of summoner ids
      # @return [Hash] league entries keyed by summoner_ids
      #
      # @example
      #   result = client.league_entries_by_summoner_ids(summoner_ids: '21066,38877656')
      #   entries = result['38877656']
      #   entry = entries.first
      #   entry_name = entry['name']
      #   entry_tier = entry['tier']
      def league_entries_by_summoner_ids(summoner_ids:)
        response_for ENTRIES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      # Challenger league data for queue type.
      #
      # @param type [String] required, must be RANKED_FLEX_SR, RANKED_FLEX_TT, RANKED_SOLO_5x5, RANKED_TEAM_3x3, or RANKED_TEAM_5x5
      # @return [Hash] challenger league data
      # @see https://developer.riotgames.com/api/methods#!/985/3353
      def challenger(type: )
        raise ArgumentError,
              "Invalid argument: #{type}, arg must be in #{CHALLENGER_QUEUE_TYPES}" unless CHALLENGER_QUEUE_TYPES.include?(type)

        response_for CHALLENGER, {type: type}
      end

      # Master league data for queue type.
      #
      # @param type [String] required, must be RANKED_FLEX_SR, RANKED_FLEX_TT, RANKED_SOLO_5x5, RANKED_TEAM_3x3, or RANKED_TEAM_5x5
      # @return [Hash] master league data
      # https://developer.riotgames.com/api/methods#!/985/3354
      def master(type: )
        raise ArgumentError,
              "Invalid argument: #{type}, arg must be in #{MASTER_QUEUE_TYPES}" unless MASTER_QUEUE_TYPES.include?(type)

        response_for MASTER, {type: type}
      end
    end
  end
end