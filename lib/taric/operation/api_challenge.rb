require_relative 'base'
require 'addressable/template'

module Taric
  module Operation
    module ApiChallenge
      include Taric::Operation::Base
      API_CHALLENGE_VERSION = 'v4.1'.freeze
      API_CHALLENGE_MATCH_IDS = Addressable::Template.new "#{BASE_URL_FN.(API_CHALLENGE_VERSION)}/game/ids{?api_key,beginDate}"

      # Match ids given a begin date
      #
      #
      def api_challenge_match_ids(begin_date:)
        response_for API_CHALLENGE_MATCH_IDS, beginDate: begin_date
      end
    end
  end
end

