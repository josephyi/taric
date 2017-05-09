# frozen_string_literal: true
require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module League
      include Taric::Operation::Base

      LEAGUES_BY_SUMMONER_ID = EndpointTemplate.new(template_url: 'https://{host}/lol/league/v3/leagues/by-summoner/{summonerId}')
      POSITION_BY_SUMMONER_ID = EndpointTemplate.new(template_url: 'https://{host}/lol/league/v3/positions/by-summoner/{summonerId}')
      CHALLENGER = EndpointTemplate.new(template_url: 'https://{host}/lol/league/v3/challengerleagues/by-queue/{queue}')
      MASTER = EndpointTemplate.new(template_url: 'https://{host}/lol/league/v3/masterleagues/by-queue/{queue}')

      CHALLENGER_QUEUE_TYPES = %w(RANKED_FLEX_SR, RANKED_FLEX_TT, RANKED_SOLO_5x5).freeze
      MASTER_QUEUE_TYPES = CHALLENGER_QUEUE_TYPES

      # Leagues by summoner ID.
      #
      # @see https://developer.riotgames.com/api-methods/#league-v3/GET_getAllLeaguesForSummoner
      # @param summoner_id [String] player's summoner ID
      # @return [Hash] leagues keyed by summoner ID
      #
      # @example
      #   result = client.leagues_by_summoner_ids(summoner_ids: '21066,38877656')
      #   leagues = result['21066']
      #   entries = first_summoner_leagues.first['entries']
      def leagues(summoner_id:)
        response_for LEAGUES_BY_SUMMONER_ID, {summonerId: summoner_id}
      end

      # League entries by summoner IDs.
      #
      # @see https://developer.riotgames.com/api-methods/#league-v3/GET_getAllLeaguePositionsForSummoner
      # @param summoner_ids summoner_ids [String] comma separated list of summoner ids
      # @return [Hash] league entries keyed by summoner_ids
      #
      # @example
      #   result = client.league_positions(summoner_id: '21066').body
      #   mapped_by_queue = result.map{ |h| [h['queueType'], h] }.to_h # {'RANKED_SOLO_5x5' => {...}}
      #   solo_queue = mapped_by_queue['RANKED_SOLO_5x5']
      #   wins = solo_queue['wins']
      #   losses = solo_queue['losses']
      def league_positions(summoner_id:)
        response_for POSITION_BY_SUMMONER_ID, {summonerId: summoner_id}
      end

      # Challenger league data for queue type.
      #
      # @param type [String] required, must be RANKED_FLEX_SR, RANKED_FLEX_TT, or RANKED_SOLO_5x5
      # @return [Hash] challenger league data
      # @see https://developer.riotgames.com/api-methods/#league-v3/GET_getChallengerLeague
      def challenger_leagues(queue: )
        raise ArgumentError,
              "Invalid argument: #{queue}, arg must be in #{CHALLENGER_QUEUE_TYPES}" unless CHALLENGER_QUEUE_TYPES.include?(queue)

        response_for CHALLENGER, {queue: queue}
      end

      # Master league data for queue type.
      #
      # @param type [String] required, must be RANKED_FLEX_SR, RANKED_FLEX_TT, or RANKED_SOLO_5x5
      # @return [Hash] master league data
      # @see https://developer.riotgames.com/api-methods/#league-v3/GET_getMasterLeague
      def master_leagues(queue: )
        raise ArgumentError,
              "Invalid argument: #{queue}, arg must be in #{MASTER_QUEUE_TYPES}" unless MASTER_QUEUE_TYPES.include?(queue)

        response_for MASTER, {queue: queue}
      end
    end
  end
end