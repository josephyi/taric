# frozen_string_literal: true
require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Champion
      include Taric::Operation::Base

      CHAMPION_BASE_URL = 'https://{host}/lol/platform/v3/champions'

      CHAMPIONS =  EndpointTemplate.new(template_url: "#{CHAMPION_BASE_URL}{?freeToPlay}")
      CHAMPION_BY_ID = EndpointTemplate.new(template_url: "#{CHAMPION_BASE_URL}/{id}")

      # Returns champion data.
      #
      # @see https://developer.riotgames.com/api/methods#!/958/3290
      # @param free_to_play [Boolean] optional, nil returns all, true or false to filter if they're free to play or not
      # @return [Hash] embedding [Array] of champions keyed off of "champions"
      #
      # @example
      #   all_champions = client.champions["champions"]
      #   free_champions = client.champions(free_to_play: true)["champions"]
      #   nonfree_champions = client.champions(free_to_play: false)["champions"]
      def champions(free_to_play: nil)
        response_for CHAMPIONS, freeToPlay: free_to_play
      end

      # Returns champion data by id.
      #
      # @see https://developer.riotgames.com/api/methods#!/958/3289
      # @param id [Fixnum] id of champion
      # @return [Hash] of champion data
      #
      # @example
      #   champion = client.champion(id: 266)
      def champion(id:)
        response_for CHAMPION_BY_ID, id: id
      end
    end
  end
end