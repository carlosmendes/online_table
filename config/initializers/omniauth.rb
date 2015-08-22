Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.omniauth_facebook_key, Rails.application.secrets.omniauth_facebook_secret
  provider :google_oauth2,  Rails.application.secrets.omniauth_google_key, Rails.application.secrets.omniauth_google_secret
end