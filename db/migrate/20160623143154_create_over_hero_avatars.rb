class CreateOverHeroAvatars < ActiveRecord::Migration
  def change
    create_table :over_hero_avatars do |t|
      t.string  :hero_name
      t.string  :hero_type
      t.string  :avatar
      t.timestamps null: false
    end
    add_index :over_hero_avatars, :hero_name
    add_index :over_hero_avatars, :hero_type
  end
end
