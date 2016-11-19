module Helpers
  module Json
    def json_response
      JSON.parse(@response.body)
    end

    def json_response_error
      JSON.parse(@response.body)['errors']
    end
  end
end
