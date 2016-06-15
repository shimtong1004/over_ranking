json.array!(@over_platforms) do |over_platform|
  json.extract! over_platform, :id
  json.url over_platform_url(over_platform, format: :json)
end
