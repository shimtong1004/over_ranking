class OverHeroCommon < ActiveRecord::Base
  belongs_to :over_hero_common_table, polymorphic: true
end
