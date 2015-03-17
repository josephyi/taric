module Taric
  module Operation
    module CurrentGame
      GAME_INFO = Addressable::Template.new 'https://{host}/observer-mode/rest/consumer/getSpectatorGameInfo/{platform_id}/{summonerId}{?api_key}'

      # Returns [Hash] of game data for summoner id
      #
      # @see {https://developer.riotgames.com/api/methods#!/956/3287}
      # @param summoner_id [Fixnum] required, id of summoner
      # @return [Hash] of game data for summoner id
      #
      # @example
      #   current_game = client.current_game(summoner_id: 21066)
      def current_game(summoner_id:)
        response_for GAME_INFO, summonerId: summoner_id
      end
    end
  end
end