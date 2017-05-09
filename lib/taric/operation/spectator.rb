# frozen_string_literal: true
require_relative 'endpoint_template'
module Taric
  module Operation
    module Spectator
      CURRENT_GAME_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/spectator/v3/active-games/by-summoner/{summonerId}{?api_key}')
      FEATURED_GAMES_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/spectator/v3/featured-games{?api_key}')

      # Returns current game data for summoner id.
      #
      # @see https://developer.riotgames.com/api-methods/#spectator-v3/GET_getCurrentGameInfoBySummoner
      # @param summoner_id [Fixnum] ID of summoner
      # @return [Response] current game
      def current_game(summoner_id: )
        response_for CURRENT_GAME_V3, {summonerId: summoner_id}
      end

      #
      # @see https://developer.riotgames.com/api-methods/#spectator-v3/GET_getFeaturedGames
      def featured_games
        response_for FEATURED_GAMES_V3
      end
    end
  end
end
