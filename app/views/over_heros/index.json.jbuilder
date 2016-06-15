json.array!(@over_heros) do |over_hero|
  json.extract! over_hero, :id
  json.url over_hero_url(over_hero, format: :json)
end
