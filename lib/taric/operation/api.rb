require_relative 'champion'
require_relative 'current_game'
require_relative 'featured_games'
require_relative 'game'
require_relative 'league'
require_relative 'lol_static_data'
require_relative 'lol_status'
require_relative 'match'
require_relative 'stats'
require_relative 'summoner'
module Taric
  module Operation
    module API
      include Taric::Operation::Champion
      include Taric::Operation::CurrentGame
      include Taric::Operation::FeaturedGames
      include Taric::Operation::Game
      include Taric::Operation::League
      include Taric::Operation::LolStaticData
      include Taric::Operation::LolStatus
      include Taric::Operation::Match
      include Taric::Operation::Stats
      include Taric::Operation::Summoner

      REGION_ENDPOINT_INFO = {
          na: {region: 'na'.freeze, platform_id: 'NA1'.freeze, host: 'na.api.pvp.net'},
          eune: {region: 'eune'.freeze, platform_id: 'EUN1'.freeze, host: 'eune.api.pvp.net'},
          br: {region: 'br'.freeze, platform_id: 'BR1'.freeze, host: 'br.api.pvp.net'}
      }.freeze

      RESPONSE = -> url, requestor, response_handler {
        response_handler.(requestor.(url))
      }.curry

    end
  end
end