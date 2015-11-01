require_relative 'base'
module Taric
  module Operation
    module Stats
      include Taric::Operation::Base

      STATS_VERSION = 'v1.3'.freeze
      BASE_STATS_URL = "#{BASE_URL_FN.(STATS_VERSION)}/stats/by-summoner/{summonerId}"
      RANKED = Addressable::Template.new "#{BASE_STATS_URL}/ranked{?api_key,season}"
      SUMMARY = Addressable::Template.new "#{BASE_STATS_URL}/summary{?api_key,season}"

      # Ranked stats for summoner.
      #
      # @see https://developer.riotgames.com/api/methods#!/1018/3452
      # @param summoner_id [Fixnum] ID of summoner
      # @param season [String] Optional - valid season
      # @return [Hash] ranked stats
      def ranked_stats(summoner_id: , season: nil)
        response_for RANKED, {summonerId: summoner_id, season: season}
      end

      # Summary stats for summoner.
      #
      # @see https://developer.riotgames.com/api/methods#!/1018/3453
      # @param summoner_id [Fixnum] ID of summoner
      # @param season [String] Optional - valid season
      # @return [Hash] various aggregate stats
      def summary_stats(summoner_id: , season: nil)
        response_for SUMMARY, {summonerId: summoner_id, season: season}
      end
    end
  end
end