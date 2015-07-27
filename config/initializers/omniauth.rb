Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Figaro.env.facebook_key, Figaro.env.facebook_secret
  provider :google_oauth2, Figaro.env.google_client_id, Figaro.env.google_client_secret
end
