require_relative 'base'
require 'addressable/template'
module Taric
  module Operation
    module League
      include Taric::Operation::Base

      LEAGUE_VERSION = 'v2.5'
      BASE_LEAGUE_URL = "#{BASE_URL_FN.(LEAGUE_VERSION)}/league"

      LEAGUES_BY_SUMMONER_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-summoner/{summonerIds}{?api_key}"
      ENTRIES_BY_SUMMONER_IDS = Addressable::Template.new "#{LEAGUES_BY_SUMMONER_IDS}/entry{?api_key}"
      LEAGUES_BY_TEAM_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-team/{teamIds}{?api_key}"
      ENTRIES_BY_TEAM_IDS = Addressable::Template.new "#{LEAGUES_BY_TEAM_IDS}/entry{?api_key}"
      CHALLENGER = Addressable::Template.new "#{BASE_LEAGUE_URL}/challenger{?api_key}"

      def leagues_by_summoner_ids(summoner_ids:)
        response_for LEAGUES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      def league_entries_by_summoner_ids(summoner_ids:)
        response_for ENTRIES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      def leagues_by_team_ids(team_ids:)
        response_for LEAGUES_BY_TEAM_IDS, {teamIds: team_ids}
      end

      def league_entries_by_team_ids(team_ids:)
        response_for ENTRIES_BY_TEAM_IDS, {teamIds: team_ids}
      end

      def challenger(type: )
        response_for CHALLENGER, {type: type}
      end
    end
  end
end