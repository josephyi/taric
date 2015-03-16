require_relative 'base'
module Taric
  module Operation
    module Summoner
      include Taric::Operation::Base
      
      VERSION = 'v1.4'
      BASE_SUMMONER_URL = "#{BASE_URL_FN.(VERSION)}/summoner"

      BY_NAMES =  Addressable::Template.new "#{BASE_SUMMONER_URL}/by-name/{summonerNames}{?api_key}"
      BY_IDS = Addressable::Template.new "#{BASE_SUMMONER_URL}/{summonerIds}{?api_key}"
      MASTERIES = Addressable::Template.new "#{BY_IDS}/masteries{?api_key}"
      NAMES = Addressable::Template.new "#{BY_IDS}/name{?api_key}"
      RUNES = Addressable::Template.new "#{BY_IDS}/rune{?api_key}"

      def summoners_by_names(names:)
        response_for BY_NAMES, {summonerNames: names}
      end

      def summoners_by_ids(summoner_ids:)
        response_for BY_IDS, {summonerIds: summoner_ids}
      end

      def masteries(summoner_ids:)
        response_for MASTERIES, {summonerIds: summoner_ids}
      end

      def name(summoner_ids)
        response_for NAME, {summonerIds: summoner_ids}
      end

      def runes(summoner_ids:)
        response_for RUNES, {summonerIds: summoner_ids}
      end

    end
  end
end