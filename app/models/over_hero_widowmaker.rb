class OverHeroWidowmaker < ActiveRecord::Base
  has_many :over_hero_common, as: :over_hero_common_table
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero_widowmaker", log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero_widowmaker", log_type: "update")
  end
end
