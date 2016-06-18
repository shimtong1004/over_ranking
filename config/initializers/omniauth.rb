Rails.application.config.middleware.use OmniAuth::Builder do
  
  if Rails.env == 'development'
    provider :bnet, "64tqt7aah64r5bvc3cjdhg64mk7vevnw", "fEpntruyAkerZ7hJbbNphYPfGh7knzdY", scope: "wow.profile sc2.profile"
    OmniAuth.config.full_host = "https://localhost:3000"
  else
    provider :bnet, "p6cxxnqks8k3xrevexv8pwk27bs83cxg", "TeWVkS9Tg9zPmkkXxaKFChCZWukYWff3", scope: "wow.profile sc2.profile"
    OmniAuth.config.full_host = "https://www.happyhouse.me"
  end
  

  enable :sessions
  enable :inline_templates
end