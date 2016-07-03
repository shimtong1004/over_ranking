class CreateOverTagTmps < ActiveRecord::Migration
  def change
    create_table :over_tag_tmps do |t|
      t.string  :tag
      t.string  :tag_head
      t.string  :tag_tail
      t.string  :region
      t.string  :platform
      t.timestamps null: false
    end
  end
end
