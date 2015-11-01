module Taric
  module Operation
    module LolStatus
      SHARDS = Addressable::Template.new 'http://status.leagueoflegends.com/shards'
      SHARD = Addressable::Template.new 'http://status.leagueoflegends.com/shards/{region}'

      # Region metadata.
      #
      # @return [Array] of region metadata in hashes
      def shards
        response_for SHARDS
      end

      # Region metadata by region.
      # @param region [String] region to load
      # @return [Hash] region info
      def shard(region:)
        response_for SHARD, {region: region}
      end
    end
  end
end