module Helpers
  module Authen
    def sign_in(user)
      auth_headers = user.create_new_auth_token
      @request.headers.merge!(auth_headers)
    end

    def set_version(version = 'v1')
      @request.headers.merge!(accept: "application/jsonl version=#{version}")
    end
  end
end
