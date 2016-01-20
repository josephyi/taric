require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Match
      include Taric::Operation::Base

      MATCH_VERSION = 'v2.2'
      MATCH = EndpointTemplate.new(template_url: "#{BASE_URL_FN.(MATCH_VERSION)}/match/{matchId}{?api_key,includeTimeline}")
      MATCH_IDS_BY_TOURNAMENT = EndpointTemplate.new(template_url: "#{BASE_URL_FN.(MATCH_VERSION)}/match/by-tournament/{tournamentCode}/ids{?api_key}")
      MATCH_FOR_TOURNAMENT = EndpointTemplate.new(template_url: "#{BASE_URL_FN.(MATCH_VERSION)}/match/for-tournament/{matchId}{?api_key,tournamentCode,includeTimeline}")

      # Match data for id.
      #
      # @see https://developer.riotgames.com/api/methods#!/1027/3483
      # @param match_id [Fixnum] id of match
      # @param include_timeline [Boolean] optional, true includes timestamps on events
      # @return match data for id.
      def match(match_id:, include_timeline: nil)
        response_for MATCH, {matchId: match_id, includeTimeline: include_timeline}
      end

      # Retrieve match IDs by tournament code.
      # @param tournament_code [String] tournament code
      # @return match ids by tournament code
      def match_ids_by_tournament(tournament_code: )
        response_for MATCH_IDS_BY_TOURNAMENT, tournamentCode: tournament_code
      end

      # Retrieve match by match ID and tournament code.
      # @param match_id [Fixnum] id of match
      # @param tournament_code [String] tournament code
      # @param include_timeline [Boolean] optional, true includes timestamps on events
      # @return match ids by tournament code
      def match_for_tournament(match_id:, tournament_code:, include_timeline: false)
        response_for MATCH_IDS_BY_TOURNAMENT, tournamentCode: tournament_code, matchId: match_id, includeTimeline: include_timeline
      end

    end
  end
end
