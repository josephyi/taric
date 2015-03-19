require_relative 'base'
module Taric
  module Operation
    module MatchHistory
      include Taric::Operation::Base

      MATCH_HISTORY_VERSION = 'v2.2'
      MATCH_HISTORY = Addressable::Template.new "#{BASE_URL_FN.(MATCH_HISTORY_VERSION)}/matchhistory/{summonerId}{?api_key,championIds,rankedQueues,beginIndex,endIndex}"

      # @see https://developer.riotgames.com/api/methods#!/966/3312
      def match_history(summoner_id:, champion_ids: nil, ranked_queues: nil, begin_index: nil, end_index: nil)
        response_for MATCH_HISTORY,
                     {summonerId: summoner_id, championIds: champion_ids, rankedQueues: ranked_queues, beginIndex: begin_index, endIndex: end_index}
      end
    end
  end
end