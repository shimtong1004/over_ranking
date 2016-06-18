class OverAllHero < ActiveRecord::Base
  belongs_to :over_tag
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_all_hero", log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_all_hero", log_type: "update")
  end
  
end
