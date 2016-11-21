module Helpers
  module Json
    def json_response
      JSON.parse(@response.body)
    end

    def json_response_error
      JSON.parse(@response.body)['errors']
    end

    def assert_403
      assert_error(403, 'PERMISSION_DENIED')
    end

    def assert_401
      assert_error(401, 'UNAUTHORIZED')
    end

    def assert_404
      assert_error(404, 'NOT_FOUND')
    end

    def assert_422
      assert_error(422, 'UNPROCESSABLE ENTITY')
    end

    private
    def assert_error(status, code)
      expect(json_response_error['status']).to eq(status)
      expect(json_response_error['code']).to eq(code)
      expect(response.status).to eq(status)
    end
  end
end
