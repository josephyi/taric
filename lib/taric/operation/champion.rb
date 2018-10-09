# frozen_string_literal: true
require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module Champion
      include Taric::Operation::Base

      CHAMPION_ROTATIONS = EndpointTemplate.new(template_url: "https://{host}/lol/platform/v3/champion-rotations")

      # Returns champion rotations, including free-to-play and low-level free-to-play rotations
      #
      # @see https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampionInfo Champion Rotations
      # @return [Hash] of free champion ids, free new player champion ids, and new player max level
      #
      # @example
      #   champion_rotations = client.champion_rotations.body
      #   free_champion_ids = champion_rotations['freeChampionIds']
      #   new_player_champion_ids = champion_rotations['freeChampionIdsForNewPlayers']
      #   max_new_player_level = champion_rotations['maxNewPlayerLevel']
      def champion_rotations
        response_for CHAMPION_ROTATIONS
      end
    end
  end
end