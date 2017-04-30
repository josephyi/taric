require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Match
      include Taric::Operation::Base

      MATCH_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/match/v3/matches/{matchId}{?api_key}')
      MATCHLIST_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/match/v3/matchlists/by-account/{accountId}{?api_key,beginTime,endIndex,season*,champion*,beginIndex,queue*,endTime}')
      MATCHLIST_RECENT_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/match/v3/matchlists/by-account/{accountId}/recent{?api_key}')
      MATCH_TIMELINE_V3 = EndpointTemplate.new(template_url: 'https://{host}/lol/match/v3/timelines/by-match/{matchId}{?api_key}')

      # Match data for id.
      #
      # @see https://developer.riotgames.com/api-methods/#match-v3/GET_getMatch
      # @param match_id [Fixnum] id of match
      # @return match data for id.
      def match(match_id: )
        response_for MATCH_V3, {matchId: match_id}
      end

      # Matchlist data
      #
      # @see https://developer.riotgames.com/api-methods/#match-v3/GET_getMatchlist
      # @param account_id [Fixnum] player's account ID
      # @param champion [Fixnum, Array<Fixnum>] Optional - Set of champion IDs for which to filtering matchlist.
      # @param queue [Fixnum, Array<Fixnum>] Optional - Set of queue IDs for which to filtering matchlist.
      # @param season [Fixnum, Array<Fixnum>] Optional - Set of season IDs for which to filtering matchlist.
      # @param begin_time [Fixnum] Optional - The begin time to use for filtering matchlist specified as epoch milliseconds.
      # @param end_time [Fixnum] Optional - The end time to use for filtering matchlist specified as epoch milliseconds.
      # @param begin_index [Fixnum] Optional - The begin index to use for filtering matchlist.
      # @param end_index [Fixnum] Optional - The end index to use for filtering matchlist.
      # @return [Response] list of match data
      #
      # @example filtering on single season and single champion
      #   client.matchlist(account_id: 47910, season: 7, champion: 113).body
      #
      # @example filtering on multiple seasons and champions
      #   client.matchlist(account_id: 47910, season: [6,7,8], champion: [16,37]).body
      def matchlist(account_id:, begin_time: nil, end_index: nil, season: nil, champion: nil, begin_index: nil, queue: nil, end_time: nil)
        response_for(
            MATCHLIST_V3,
            {
              accountId: account_id,
              beginTime: epoch_milliseconds(begin_time),
              endIndex: end_index,
              season: season,
              champion: champion,
              beginIndex: begin_index,
              queue: queue,
              endTime: epoch_milliseconds(end_time)
            }
        )
      end

      # Matchlist data for the past 20 matches
      #
      # @see https://developer.riotgames.com/api-methods/#match-v3/GET_getRecentMatchlist
      # @param account_id [Fixnum] player's account ID
      # @return [Response] list of last 20 matches
      def matchlist_recent(account_id: )
        response_for MATCHLIST_RECENT_V3, {accountId: account_id}
      end

      # Match timeline data
      #
      # @see https://developer.riotgames.com/api-methods/#match-v3/GET_getMatchTimeline
      # @param match_id [Fixnum] id of match
      # @return [Response] match timeline
      def match_timeline(match_id: )
        response_for MATCH_TIMELINE_V3, {matchId: match_id}
      end
    end
  end
end
