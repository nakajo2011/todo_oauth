require File.expand_path('../../../lib/omniauth/strategies/mock', __FILE__)

Rails.application.config.middleware.use OmniAuth::Builder do
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
end