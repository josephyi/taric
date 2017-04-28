require_relative 'endpoint_template'
module Taric
  module Operation
    module LolStatus
      SHARD =  EndpointTemplate.new(template_url: 'https://{host}/lol/status/v3/shard-data{?api_key}')

      # Region metadata, implicitly uses endpoint host to determine which region.
      #
      # @return [Hash] region info
      def shard_data
        response_for SHARD
      end
    end
  end
end