require 'base64'

module OmniAuth
  module Strategies
    class EpicGame < OmniAuth::Strategies::OAuth2
      # enable oauth debug log

      RAW_INFO_URL = 'https://api.epicgames.dev/epic/oauth/v1/userInfo'
      option :name, 'epic_game'
      option :scope, "basic_profile"
      option :client_options,
          site: 'https://api.epicgames.dev/',
          authorize_url: "https://www.epicgames.com/id/authorize",
          token_url: "https://api.epicgames.dev/epic/oauth/v1/token"


      uid { raw_info['uid'] }

      info do
        {
          email: raw_info['email'],
          name: raw_info['name']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        puts "access_token=#{access_token}"
        response access_token.get(RAW_INFO_URL).response
        puts "userInfo=#{response.body}"

        return {'uid': 1, 'email': "test@example.com", 'name': "nakajo"}
      end

      def authorize_params
        params = super
        puts "DEBUG=#{ENV['OAUTH_DEBUG']}"
        puts "authroize_params: omniauth.state=#{session["omniauth.state"]}"
        puts "authroize_params: session=#{session["session_id"]}"
        params
      end

      def callback_phase

        puts "callback_phase: omniauth.state=#{session["omniauth.state"]}"
        puts "callback_phase: session=#{session["session_id"]}"
        puts "callback_phase: request=#{request.params}"
        request.each_header do |name, v|
          puts "callback_phase: request.header=#{name}:#{v}"
        end
        puts "callback_phase: token_url=#{client.token_url}"
        super
      end

      def build_access_token
        verifier = request.params["code"]
        token_options = options.auth_token_params.merge({headers: {'Authenticate': 'Basic ' + basic_auth_info}})
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(token_options))
      end

      def basic_auth_info
        Base64.urlsafe_encode64(options[:client_id] + ":" + options[:client_secret])
      end
    end
  end
end