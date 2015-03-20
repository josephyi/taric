require_relative 'base'
require 'addressable/template'
module Taric
  module Operation
    module League
      include Taric::Operation::Base

      LEAGUE_VERSION = 'v2.5'
      BASE_LEAGUE_URL = "#{BASE_URL_FN.(LEAGUE_VERSION)}/league"

      LEAGUES_BY_SUMMONER_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-summoner/{summonerIds}{?api_key}"
      ENTRIES_BY_SUMMONER_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-summoner/{summonerIds}/entry{?api_key}"
      LEAGUES_BY_TEAM_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-team/{teamIds}{?api_key}"
      ENTRIES_BY_TEAM_IDS = Addressable::Template.new "#{BASE_LEAGUE_URL}/by-team/{teamIds}/entry{?api_key}"
      CHALLENGER = Addressable::Template.new "#{BASE_LEAGUE_URL}/challenger{?api_key,type}"

      CHALLENGER_QUEUE_TYPES = ['RANKED_SOLO_5x5'.freeze, 'RANKED_TEAM_3x3'.freeze, 'RANKED_TEAM_5x5'.freeze].freeze

      # @see https://developer.riotgames.com/api/methods#!/936/3241
      def leagues_by_summoner_ids(summoner_ids:)
        response_for LEAGUES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      # @see https://developer.riotgames.com/api/methods#!/936/3245
      def league_entries_by_summoner_ids(summoner_ids:)
        response_for ENTRIES_BY_SUMMONER_IDS, {summonerIds: summoner_ids}
      end

      # @see https://developer.riotgames.com/api/methods#!/936/3242
      def leagues_by_team_ids(team_ids:)
        response_for LEAGUES_BY_TEAM_IDS, {teamIds: team_ids}
      end

      # @see https://developer.riotgames.com/api/methods#!/936/3244
      def league_entries_by_team_ids(team_ids:)
        response_for ENTRIES_BY_TEAM_IDS, {teamIds: team_ids}
      end

      # Challenger league data for type.
      #
      # @param type [String] required, must be RANKED_SOLO_5x5, RANKED_TEAM_3x3, or RANKED_TEAM_5x5
      # @see https://developer.riotgames.com/api/methods#!/936/3243
      def challenger(type: )
        raise ArgumentError,
              "Invalid argument: #{type}, arg must be in #{CHALLENGER_QUEUE_TYPES}" unless CHALLENGER_QUEUE_TYPES.include?(type)

        response_for CHALLENGER, {type: type}
      end
    end
  end
end