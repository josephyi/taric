module Taric
  module Operation
    module CurrentGame
      GAME_INFO = Addressable::Template.new 'https://{host}/observer-mode/rest/consumer/getSpectatorGameInfo/{platform_id}/{summonerId}{?api_key}'

      def current_game(summoner_id:)
        response_for GAME_INFO, summonerId: summoner_id
      end
    end
  end
end