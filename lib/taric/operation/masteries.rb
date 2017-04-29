require_relative 'endpoint_template'
module Taric
  module Operation
    module Masteries

      MASTERIES = EndpointTemplate.new(template_url: "https://{host}/lol/platform/v3/masteries/by-summoner/{summonerId}{?api_key}")

      # Masteries by summoner ID.
      #
      # @param summoner_id [Fixnum] Summoner ID
      # @return [Hash] masteries for Summoner ID
      def masteries(summoner_id: )
        response_for MASTERIES, {summonerId: summoner_id}
      end
    end
  end
end