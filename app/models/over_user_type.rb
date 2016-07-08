class OverUserType < ActiveRecord::Base
  has_many :over_hero_masters
  belongs_to :over_tag
end
