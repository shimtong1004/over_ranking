class OverHero < ActiveRecord::Base
  belongs_to :over_tag
  has_one :over_hero_common
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero", sub_name: self.name, log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero", sub_name: self.name, log_type: "update")
  end
  
  def self.main_hero(tag_id)
    hero = OverHero.where(over_tag_id: tag_id).order("playtime_min desc").first
  end
end
