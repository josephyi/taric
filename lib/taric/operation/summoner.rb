require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Summoner
      include Taric::Operation::Base

      RUNES_AND_MASTERIES_BASE = "https://{host}/api/lol/{region}/v1.4/summoner/{summonerIds}"
      MASTERIES =  EndpointTemplate.new(template_url: "#{RUNES_AND_MASTERIES_BASE}/masteries{?api_key}")
      RUNES =  EndpointTemplate.new(template_url: "#{RUNES_AND_MASTERIES_BASE}/runes{?api_key}")

      # Masteries keyed by summoner ID.
      #
      # @param summoner_ids [String] comma separated list of Summoner IDs
      # @return [Hash] masteries by Summoner ID
      def summoner_masteries(summoner_ids:)
        response_for MASTERIES, {summonerIds: summoner_ids}
      end

      # Runes keyed by summoner ID.
      #
      # @param summoner_ids [String] comma separated list of Summoner IDs
      # @return [Hash] runes by Summoner ID
      def summoner_runes(summoner_ids:)
        response_for RUNES, {summonerIds: summoner_ids}
      end

      BASE_SUMMONER_URL = "https://{host}/lol/summoner/v3/summoners"
      SUMMONER_BY_ID = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/{summonerId}{?api_key}")
      SUMMONER_BY_NAME = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/by-name/{summonerName}{?api_key}")
      SUMMONER_BY_ACCOUNT_ID = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/by-account/{accountId}{?api_key}")

      def summoner_by_id(summoner_id:)
        response_for SUMMONER_BY_ID, {summonerId: summoner_id}
      end

      def summoner_by_name(summoner_name:)
        response_for SUMMONER_BY_NAME, {summonerName: summoner_name}
      end

      def summoner_by_account_id(account_id:)
        response_for SUMMONER_BY_ACCOUNT_ID, {accountId: account_id}
      end

    end
  end
end
