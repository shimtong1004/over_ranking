class OverUserType < ActiveRecord::Base
  has_many :over_hero_masters
  has_many :over_user_scores
  has_many :heros
  has_many :hero_groups
  belongs_to :over_tag
end
