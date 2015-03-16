require_relative 'base'
module Taric
  module Operation
    module Team
      include Taric::Operation::Base

      TEAM_VERSION = 'v2.4'.freeze
      BASE_TEAM_URL = "#{BASE_URL_FN.(TEAM_VERSION)}/team"

      TEAMS_BY_SUMMONER_IDS = Addressable::Template.new "#{BASE_TEAM_URL}/by-summoner/{summonerIds}"
      TEAMS_BY_TEAM_IDS = Addressable::Template.new "#{BASE_TEAM_URL}/{teamIds}"

      def teams_by_summoner_ids(summoner_ids:)
        response_for TEAMS_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      def teams(team_ids:)
        response_for TEAMS_BY_TEAM_IDS, {teamIds: team_ids}
      end
    end
  end
end

