module OmniAuth
  module Strategies
    class Mock < OmniAuth::Strategies::OAuth2
      RAW_INFO_URL = 'api/v1/me'

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
        @raw_info ||= JSON.parse(access_token.get(RAW_INFO_URL).response.body)
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