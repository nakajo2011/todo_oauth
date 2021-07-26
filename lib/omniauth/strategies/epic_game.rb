module OmniAuth
  module Strategies
    class EpicGame < OmniAuth::Strategies::OAuth2
      RAW_INFO_URL = 'epic/oauth/v1/userInfo'
      option :name, 'epic_game'
      option :scope, "basic_profile"
      option :client_options,
          site: 'https://api.epicgames.dev/',
          authorize_url: "https://www.epicgames.com/id/authorize",
          token_url: "epic/oauth/v1/token"

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
        return {'uid': 1, 'email': "test@example.com", 'name': "nakajo"}
      end

      def authorize_params
        params = super
        puts "authroize_params: omniauth.state=#{session["omniauth.state"]}"
        puts "authroize_params: session=#{session["session_id"]}"
        params
      end

      def callback_phase

        puts "callback_phase: omniauth.state=#{session["omniauth.state"]}"
        puts "callback_phase: session=#{session["session_id"]}"
        puts "callback_phase: request=#{request.params}"
        super
      end
    end
  end
end