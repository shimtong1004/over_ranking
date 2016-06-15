json.array!(@over_achievements) do |over_achievement|
  json.extract! over_achievement, :id
  json.url over_achievement_url(over_achievement, format: :json)
end
