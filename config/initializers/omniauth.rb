Rails.application.config.middleware.use OmniAuth::Builder do
  provider :bnet, "p6cxxnqks8k3xrevexv8pwk27bs83cxg", "TeWVkS9Tg9zPmkkXxaKFChCZWukYWff3", scope: "wow.profile sc2.profile"
  OmniAuth.config.full_host = "https://localhost:3000"

  enable :sessions
  enable :inline_templates
end