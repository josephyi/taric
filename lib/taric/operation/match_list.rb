require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module MatchList
      include Taric::Operation::Base

      MATCH_LIST_VERSION = 'v2.2'.freeze
      MATCH_LIST =  EndpointTemplate.new(template_url: "#{BASE_URL_FN.(MATCH_LIST_VERSION)}/matchlist/by-summoner/{summonerId}{?api_key,championIds,rankedQueues,seasons,beginTime,endTime,beginIndex,endIndex}")

      # Returns match list for summoner.
      #
      # @see https://developer.riotgames.com/api/methods#!/1026/3480
      # @param summoner_id [Fixnum] summoner Id
      # @param champion_ids [String] Optional - Comma-separated list of champion IDs to use for fetching games.
      # @param ranked_queues [String] Optional - Comma-separated list of ranked queue types to use for fetching games. Non-ranked queue types will be ignored.
      # @param seasons [String] Optional  - Comma-separated list of seasons to use for fetching games.
      # @param begin_time [Fixnum or Time] Optional - The begin time to use for fetching games.
      # @param end_time [Fixnum or Time] Optional - The end time to use for fetching games.
      def match_list(summoner_id:, champion_ids: nil, ranked_queues: nil, seasons: nil, begin_time: nil, end_time: nil, begin_index: nil, end_index: nil)
        response_for MATCH_LIST,
                     {summonerId: summoner_id, championIds: champion_ids, rankedQueues: ranked_queues, seasons: seasons, beginTime: epoch_milliseconds(begin_time), endTime: epoch_milliseconds(end_time), beginIndex: begin_index, endIndex: end_index}
      end

    end
  end
end