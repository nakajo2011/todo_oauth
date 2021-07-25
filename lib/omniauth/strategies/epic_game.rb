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
    end
  end
end