require_relative 'champion'
require_relative 'champion_mastery'
require_relative 'league'
require_relative 'lol_status'
require_relative 'masteries'
require_relative 'match'
require_relative 'runes'
require_relative 'spectator'
require_relative 'summoner'

# Combines operations of LoL API.
module Taric
  module Operation
    module API
      include Taric::Operation::Champion
      include Taric::Operation::ChampionMastery
      include Taric::Operation::League
      include Taric::Operation::LolStatus
      include Taric::Operation::Masteries
      include Taric::Operation::Match
      include Taric::Operation::Runes
      include Taric::Operation::Spectator
      include Taric::Operation::Summoner

      # Template for requesting the url and processing the response.
      #
      # @param url String
      # @param requestor Proc (lambda)
      # @param response_handler Proc (lambda)
      API_CALL = -> (method, url, body, headers, requestor, response_handler) {
        response_handler.(requestor.(method, url, body, headers))
      }

    end
  end
end