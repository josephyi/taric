require_relative 'endpoint_template'
module Taric
  module Operation
    module FeaturedGames
      FEATURED_GAMES = EndpointTemplate.new(template_url:'https://{host}/observer-mode/rest/featured{?api_key}')

      # Returns featured games.
      #
      # @see https://developer.riotgames.com/api/methods#!/957/3288
      # @return [Hash] of featured games in [Array] keyed by 'gameList'
      #
      # @example
      #   featured_games = client.featured_games['gameList']
      def featured_games
        response_for FEATURED_GAMES
      end
    end
  end
end
