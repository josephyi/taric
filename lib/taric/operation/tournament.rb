require_relative 'base'
require_relative 'endpoint_template'
require 'oj'
module Taric
  module Operation
    module Tournament
      include Taric::Operation::Base

      TOURNAMENT_VERSION = 'v1'.freeze
      PROVIDER_URL = "https://global.api.pvp.net/tournament/public/#{TOURNAMENT_VERSION}/provider".freeze
      TOURNAMENT_URL = "https://global.api.pvp.net/tournament/public/#{TOURNAMENT_VERSION}/tournament".freeze
      CODE_URL = "https://global.api.pvp.net/tournament/public/#{TOURNAMENT_VERSION}/code{?tournamentId,count}".freeze
      TOURNAMENT_BY_CODE_URL = "https://global.api.pvp.net/tournament/public/#{TOURNAMENT_VERSION}/code/{tournamentCode}".freeze
      LOBBY_EVENTS_BY_CODE_URL = "https://global.api.pvp.net/tournament/public/#{TOURNAMENT_VERSION}/lobby/events/by-code/{tournamentCode}".freeze


      # Creates a tournament provider and returns its ID.
      #
      def create_provider(region:, url: )
         response_for EndpointTemplate.new(template_url: PROVIDER_URL, method: :post, headers: {"X-Riot-Token" => @api_key, "Content-Type" => 'application/json'}, body: "{\"region\": \"#{region}\", \"url\": \"#{url}\"}")
      end

      # Creates a tournament and returns its ID.
      #
      def create_tournament(name: '', provider_id: )
        response_for EndpointTemplate.new(template_url: TOURNAMENT_URL, method: :post, headers: {"X-Riot-Token" => @api_key, "Content-Type" => 'application/json'}, body: "{\"name\": \"#{name}\", \"providerId\": #{provider_id}}")
      end

      def create_tournament_codes(tournament_id: , count:, allowed_summoner_ids: [], map_type:, metadata: nil, pick_type:,  spectator_type:, team_size: )
        body = {'mapType'.freeze => map_type, 'teamSize'.freeze => team_size, 'pickType'.freeze => pick_type, 'spectatorType'.freeze => spectator_type}
        body.merge!('metadata'.freeze => metadata) unless metadata.nil?
        body.merge!('allowed_summoner_ids'.freeze => {'participants'.freeze => allowed_summoner_ids}) unless allowed_summoner_ids.empty?
        response_for(EndpointTemplate.new(template_url: CODE_URL, method: :post, headers: {'X-Riot-Token'.freeze => @api_key, 'Content-Type'.freeze => 'application/json'.freeze},
                                          body: Oj.dump(body)), tournamentId: tournament_id, count: count)
      end

      def tournament_by_code(tournament_code: )
        response_for EndpointTemplate.new(template_url: TOURNAMENT_BY_CODE_URL, headers: {'X-Riot-Token'.freeze => @api_key, 'Content-Type'.freeze => 'application/json'.freeze}), tournamentCode: tournament_code
      end

      # Update the pick type, map, spectator type, or allowed summoners for a code
      def update_tournament(tournament_code:, allowed_participants: nil, spectator_type: nil, pick_type: nil, map_type: nil)
        body = {'spectatorType'.freeze => spectator_type, 'pickType'.freeze => pick_type, 'mapType'.freeze => map_type, 'allowedParticipants'.freeze => allowed_participants}.select!{ |_, v| !v.nil? }
        response_for EndpointTemplate.new(template_url: TOURNAMENT_BY_CODE_URL, headers: {'X-Riot-Token'.freeze => @api_key, 'Content-Type'.freeze => 'application/json'.freeze},
                     body: Oj.dump(body), method: :put), tournamentCode: tournament_code
      end

      def lobby_events_by_code(tournament_code: )
        response_for EndpointTemplate.new(template_url: LOBBY_EVENTS_BY_CODE_URL, headers: {'X-Riot-Token'.freeze => @api_key, 'Content-Type'.freeze => 'application/json'.freeze}), tournamentCode: tournament_code
      end
    end
  end
end