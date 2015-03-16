module Taric
  module Operation
    module LolStatus
      SHARDS = Addressable::Template.new 'http://status.leagueoflegends.com/shards'
      SHARD = Addressable::Template.new 'http://status.leagueoflegends.com/shards/{region}'

      def shards
        response_for SHARDS
      end

      def shard(region:)
        response_for SHARD, {region: region}
      end
    end
  end
end