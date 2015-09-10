require_relative 'api_challenge'
require_relative 'champion'
require_relative 'current_game'
require_relative 'featured_games'
require_relative 'game'
require_relative 'league'
require_relative 'lol_static_data'
require_relative 'lol_status'
require_relative 'match'
require_relative 'match_history'
require_relative 'match_list'
require_relative 'stats'
require_relative 'summoner'
require_relative 'team'
module Taric
  module Operation
    module API
      include Taric::Operation::ApiChallenge
      include Taric::Operation::Champion
      include Taric::Operation::CurrentGame
      include Taric::Operation::FeaturedGames
      include Taric::Operation::Game
      include Taric::Operation::League
      include Taric::Operation::LolStaticData
      include Taric::Operation::LolStatus
      include Taric::Operation::Match
      include Taric::Operation::MatchHistory
      include Taric::Operation::MatchList
      include Taric::Operation::Stats
      include Taric::Operation::Summoner
      include Taric::Operation::Team

      # Template for requesting the url and processing the response.
      #
      # @param url String
      # @param requestor Proc (lambda)
      # @param response_handler Proc (lambda)
      API_CALL = -> (url:, requestor:, response_handler:) {
        response_handler.(requestor.(url))
      }

    end
  end
end