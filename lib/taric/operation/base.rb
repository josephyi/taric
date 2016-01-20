module Taric
  module Operation
    module Base

      BASE_URL_FN = -> version {"https://{host}/api/lol/{region}/#{version}"}

      # Converts [Time] to [Fixnum], or returns argument.
      #
      # @param time [Time] Time to convert to epoch.
      # @return [Fixnum] Time in epoch milliseconds.``
      def epoch_milliseconds(time)
        return (time.to_f * 1000).to_i if time.instance_of? Time
        time
      end
    end
  end
end