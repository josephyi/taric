require_relative 'base'
require 'addressable/template'
module Taric
  module Operation
    module Champion
      include Taric::Operation::Base

      CHAMPION_VERSION = 'v1.2'.freeze
      CHAMPION_BASE_URL = "#{BASE_URL_FN.(CHAMPION_VERSION)}/champion"

      CHAMPIONS =  Addressable::Template.new("#{CHAMPION_BASE_URL}{?api_key,freeToPlay}")
      CHAMPION_BY_ID = Addressable::Template.new("#{CHAMPION_BASE_URL}/{id}{?api_key}")

      def champions(free_to_play: nil)
        response_for CHAMPIONS, freeToPlay: free_to_play
      end

      def champion(id:)
        response_for CHAMPION_BY_ID, id: id
      end
    end
  end
end