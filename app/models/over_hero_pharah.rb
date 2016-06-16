class OverHeroPharah < ActiveRecord::Base
  has_many :over_hero_common, as: :over_hero_common_table
end
