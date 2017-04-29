require_relative 'endpoint_template'
module Taric
  module Operation
    module Runes

      RUNES_V3 = EndpointTemplate.new(template_url: "https://{host}/lol/platform/v3/runes/by-summoner/{summonerId}{?api_key}")

      # Runes by summoner ID.
      #
      # @param summoner_id [Fixnum] Summoner ID
      # @return [Hash] runes for Summoner ID
      def runes(summoner_id: )
        response_for RUNES_V3, {summonerId: summoner_id}
      end
    end
  end
end