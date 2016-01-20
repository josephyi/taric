require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Game
      include Taric::Operation::Base

      GAME_VERSION = 'v1.3'.freeze
      RECENT = EndpointTemplate.new(template_url:"#{BASE_URL_FN.(GAME_VERSION)}/game/by-summoner/{summonerId}/recent{?api_key}")

      # Returns recent game data for summoner id.
      #
      # @see https://developer.riotgames.com/api/methods#!/959/3291
      # @param summoner_id [Fixnum] required, id of summoner
      # @return [Hash] of recent game data for summoner id
      #
      # @example
      #   recent_games = client.recent_game(summoner_id: 21066)['games']
      def recent_games(summoner_id:)
        response_for RECENT, {summonerId: summoner_id}
      end
    end
  end
end