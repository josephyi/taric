module Taric
  module Operation
    module Base
      BASE_URL_FN = -> version {"https://{host}/api/lol/{region}/#{version}"}

      # Converts [Time] to [Fixnum], or returns argument.
      #
      # @param time [Time] Time to convert to epoch.
      # @return [Fixnum] Time in epoch.
      def epoch_time(time)
        return time.to_i if time.instance_of? Time
        time
      end
    end
  end
end