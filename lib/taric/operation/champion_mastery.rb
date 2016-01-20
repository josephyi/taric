require_relative 'base'
module Taric
  module Operation
    module ChampionMastery
      include Taric::Operation::Base

      PLATFORM_ID = 'NA1'
      BASE_MASTERY_URL = "https://global.api.pvp.net/championmastery/location/#{PLATFORM_ID}/player"
      MASTERY_BY_CHAMPION_ID = Addressable::Template.new "#{BASE_MASTERY_URL}/{summonerId}/champion/{championId}{?api_key}"
      MASTERY_ALL_CHAMPIONS = Addressable::Template.new "#{BASE_MASTERY_URL}/{summonerId}/champions{?api_key}"
      MASTERY_SCORE = Addressable::Template.new "#{BASE_MASTERY_URL}/{summonerId}/score{?api_key}"
      MASTERY_TOP_CHAMPIONS = Addressable::Template.new "#{BASE_MASTERY_URL}/{summonerId}/topchampions{?api_key,count}"

      def champion_mastery(summoner_id: , champion_id:)
        response_for MASTERY_BY_CHAMPION_ID, {summonerId: summoner_id, championId: champion_id}
      end

      def champion_mastery_all(summoner_id: )
        response_for MASTERY_ALL_CHAMPIONS, {summonerId: summoner_id}
      end

      def champion_mastery_score(summoner_id: )
        response_for MASTERY_SCORE, {summonerId: summoner_id}
      end

      def top_champions(summoner_id: , count: 3)
        response_for MASTERY_TOP_CHAMPIONS, {summonerId: summoner_id, count: count}
      end
    end
  end
end
