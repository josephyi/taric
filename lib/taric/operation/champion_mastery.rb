require_relative 'base'
module Taric
  module Operation
    module ChampionMastery
      include Taric::Operation::Base

      BASE_MASTERY_URL = "https://{host}/lol/champion-mastery/v3"
      MASTERY_ALL_CHAMPIONS = EndpointTemplate.new(template_url: "#{BASE_MASTERY_URL}/champion-masteries/by-summoner/{summonerId}{?api_key}")
      MASTERY_BY_CHAMPION_ID = EndpointTemplate.new(template_url: "#{BASE_MASTERY_URL}/champion-masteries/by-summoner/{summonerId}/by-champion/{championId}{?api_key}")
      MASTERY_SCORE = EndpointTemplate.new(template_url: "#{BASE_MASTERY_URL}/scores/by-summoner/{summonerId}{?api_key}")

      def champion_mastery(summoner_id: , champion_id:)
        response_for MASTERY_BY_CHAMPION_ID, {summonerId: summoner_id, championId: champion_id}
      end

      def champion_masteries(summoner_id: )
        response_for MASTERY_ALL_CHAMPIONS, {summonerId: summoner_id}
      end

      def champion_mastery_score(summoner_id: )
        response_for MASTERY_SCORE, {summonerId: summoner_id}
      end

    end
  end
end
