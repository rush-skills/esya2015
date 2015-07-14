Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_APP_ID"], ENV["GOOGLE_APP_SECRET"]
  provider :facebook, ENV["FB_APP_ID"], ENV["FB_APP_SECRET"],  {:scope => 'email'}
end