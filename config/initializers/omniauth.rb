   Rails.application.config.middleware.use OmniAuth::Builder do
      # provider :facebook, 'APP_KEY', 'APP_SECRET'
        provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'] 
    end
