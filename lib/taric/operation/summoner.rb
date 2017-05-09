# frozen_string_literal: true
require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Summoner
      include Taric::Operation::Base

      BASE_SUMMONER_URL = 'https://{host}/lol/summoner/v3/summoners'
      SUMMONER_BY_ID = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/{summonerId}")
      SUMMONER_BY_NAME = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/by-name/{summonerName}")
      SUMMONER_BY_ACCOUNT_ID = EndpointTemplate.new(template_url: "#{BASE_SUMMONER_URL}/by-account/{accountId}")

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
