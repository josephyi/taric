require_relative 'base'
module Taric
  module Operation
    module Team
      include Taric::Operation::Base

      TEAM_VERSION = 'v2.4'.freeze
      BASE_TEAM_URL = "#{BASE_URL_FN.(TEAM_VERSION)}/team"

      TEAMS_BY_SUMMONER_IDS = Addressable::Template.new "#{BASE_TEAM_URL}/by-summoner/{summonerIds}"
      TEAMS_BY_TEAM_IDS = Addressable::Template.new "#{BASE_TEAM_URL}/{teamIds}"

      # Teams by summoner ids.
      #
      # @param summoner_ids [String] comma separated list of summoner ids
      # @return [Hash] team info by summoner id
      # @see https://developer.riotgames.com/api/methods#!/986/3358
      def teams_by_summoner_ids(summoner_ids:)
        response_for TEAMS_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      # Teams by team ids.
      #
      # @param team_ids [String] comma separated list of team ids
      # @return [Hash] team info by team IDs
      # @see https://developer.riotgames.com/api/methods#!/986/3357
      def teams(team_ids:)
        response_for TEAMS_BY_TEAM_IDS, {teamIds: team_ids}
      end
    end
  end
end

