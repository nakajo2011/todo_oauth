require File.expand_path('../../../lib/omniauth/strategies/mock', __FILE__)
require File.expand_path('../../../lib/omniauth/strategies/epic_game', __FILE__)

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  provider :google_oauth2,
           Rails.application.credentials.google[:client_id],
           Rails.application.credentials.google[:client_secret]

  # id_provider could not be provided on localhost together this app.
  # it happen cookie and tcp connection problems.
  provider :mock,
           "abudY2tA-IifFt7u3zWSTm4RghnmZr1bLqdNTgFauKw",
           "c2a0srBKARHH_laWdedyFGCrEZVcZR-1C8AWkDbOtXU",
           scope: "read",
           client_options: { site: 'https://nakajoidprovider.herokuapp.com/'}

  provider :epic_game,
           Rails.application.credentials.epic_games[:client_id],
           Rails.application.credentials.epic_games[:client_secret],
           scope: "basic_profile",
           client_options: {
             site: 'https://www.epicgames.com/',
             authorize_url: "/id/authorize"}

end