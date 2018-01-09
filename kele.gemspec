require 'httparty'
require 'json'

class Kele
    include HTTParty
    include Roadmap

    def initialize(email, password)
        @options = { body: { "email": email, "password": password } }
        response = self.class.post("https://www.bloc.io/api/v1/sessions", @options)
        raise "invalid email or password" if response.code == 401
        @auth_token = response["auth_token"]
    end

    def get_me
        response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end

  end
