class OverHeroCommon < ActiveRecord::Base
  belongs_to :over_hero_common_table, polymorphic: true
  belongs_to :over_hero
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.over_hero_common_table.over_tag_id, table_name: "over_hero_common", sub_name: self.over_hero_common_table_type, log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.over_hero_common_table.over_tag_id, table_name: "over_hero_common", sub_name: self.over_hero_common_table_type, log_type: "update")
  end
end
