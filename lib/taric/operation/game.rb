require_relative 'base'
module Taric
  module Operation
    module Game
      include Taric::Operation::Base

      GAME_VERSION = 'v1.3'.freeze
      RECENT = Addressable::Template.new "#{BASE_URL_FN.(GAME_VERSION)}/game/by-summoner/{summonerId}/recent{?api_key}"

      def recent_games(summoner_id:)
        response_for RECENT, {summonerId: summoner_id}
      end
    end
  end
end