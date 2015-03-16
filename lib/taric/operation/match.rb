require_relative 'base'
module Taric
  module Operation
    module Match
      include Taric::Operation::Base

      MATCH_VERSION = 'v2.2'
      MATCH = Addressable::Template.new "#{BASE_URL_FN.(MATCH_VERSION)}/match/{matchId}"

      def match(id:, include_timeline: nil)
        response_for MATCH, {matchId: id, includeTimeline: include_timeline}
      end
    end
  end
end