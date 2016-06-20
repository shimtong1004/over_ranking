class OverHeroMei < ActiveRecord::Base
  has_many :over_hero_common, as: :over_hero_common_table
  belongs_to :over_tag
  
  after_create :create_log_data
  after_update :update_log_data
  
  def create_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero_mei", log_type: "create")
  end
  
  def update_log_data
    UpdateLog.create(over_tag_id: self.over_tag_id, table_name: "over_hero_mei", log_type: "update")
  end
end
