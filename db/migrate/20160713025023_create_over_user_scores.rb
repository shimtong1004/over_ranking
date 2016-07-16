class CreateOverUserScores < ActiveRecord::Migration
  def change
    create_table :over_user_scores do |t|
      t.integer :over_user_type_id
      t.string  :user_type
      t.integer :play_type
      t.string  :keyword
      t.decimal :score, precision: 11, scale: 2
      t.timestamps null: false
    end
    add_index :over_user_scores, :over_user_type_id #삭제...등
    add_index :over_user_scores, [:over_user_type_id, :play_type], name: "id_play_type" #유저 전체값 찾을때
    add_index :over_user_scores, [:over_user_type_id, :play_type, :keyword], name: "id_type_key"  #유저 값 찾을때
    add_index :over_user_scores, [:play_type, :user_type, :keyword, :score], name: "play_key_score" #랭킹용
  end
end
