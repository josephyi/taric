require_relative 'base'
module Taric
  module Operation
    module Match
      include Taric::Operation::Base

      MATCH_VERSION = 'v2.2'
      MATCH = Addressable::Template.new "#{BASE_URL_FN.(MATCH_VERSION)}/match/{matchId}{?api_key,includeTimeline}"

      # Match data for id.
      #
      # @see https://developer.riotgames.com/api/methods#!/1027/3483
      # @param id [Fixnum] id of match
      # @param include_timeline [Boolean] optional, true includes timestamps on events
      # @return match data for id.
      def match(id:, include_timeline: nil)
        response_for MATCH, {matchId: id, includeTimeline: include_timeline}
      end
    end
  end
end
