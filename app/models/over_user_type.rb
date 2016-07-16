class OverUserType < ActiveRecord::Base
  has_many :over_hero_masters
  has_many :over_user_scores
  belongs_to :over_tag
end
