module Taric
  module Operation
    module FeaturedGames
      FEATURED_GAMES = Addressable::Template.new 'https://{host}/observer-mode/rest/featured{?api_key}'

      def featured_games
        response_for FEATURED_GAMES
      end
    end
  end
end
