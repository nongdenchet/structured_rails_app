module Helpers
  module Json
    def json_response
      JSON.parse(@response.body)
    end
  end
end
