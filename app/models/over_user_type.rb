class OverUserType < ActiveRecord::Base
  has_many :heros
  has_many :hero_groups
  has_many :over_daily_datums
  belongs_to :over_tag
end
