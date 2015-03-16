require_relative 'base'
module Taric
  module Operation
    module Stats
      include Taric::Operation::Base

      STATS_VERSION = 'v1.3'.freeze
      BASE_STATS_URL = Addressable::Template.new "#{BASE_URL_FN.(STATS_VERSION)}/stats/by-summoner/{summonerId}{?api_key}"
      RANKED = Addressable::Template.new "#{BASE_STATS_URL}/ranked{?api_key}"
      SUMMARY = Addressable::Template.new "#{BASE_STATS_URL}/summary{?api_key}"

      def ranked(summoner_id: , season: nil)
        response_for RANKED, {summonerId: summoner_id, season: season}
      end

      def summary(summoner_id: , season: nil)
        response_for SUMMARY, {summonerId: summoner_id, season: season}
      end
    end
  end
end