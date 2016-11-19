module Helpers
  module Json
    def json_response
      JSON.parse(@response.body)
    end

    def json_response_error
      JSON.parse(@response.body)['errors']
    end

    def assert_403
      expect(json_response_error['status']).to eq(403)
      expect(json_response_error['code']).to eq('PERMISSION_DENIED')
    end

    def assert_401
      expect(json_response_error['status']).to eq(401)
      expect(json_response_error['code']).to eq('UNAUTHORIZED')
    end

    def assert_404
      expect(json_response_error['status']).to eq(404)
      expect(json_response_error['code']).to eq('NOT_FOUND')
    end
  end
end
