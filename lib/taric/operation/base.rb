module Taric
  module Operation
    module Base
      BASE_URL_FN = -> version {"https://{host}/api/lol/{region}/#{version}"}

    end
  end
end