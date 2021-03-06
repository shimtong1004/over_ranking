class CreateOverDailyData < ActiveRecord::Migration
  def change
    create_table :over_daily_data do |t|
      t.integer :over_user_type_id
      t.string  :hero_name
      t.integer :play_type  #빠른대전/경쟁전
      t.integer :games_won  #승리한 게임
      t.integer :games_lost #진게임
      t.integer :games_played #치른 게임
      t.integer :games_played #치른 게임
      t.float   :games_won_per
      t.integer :time_played  #플레이 시간
      t.integer :eliminations #처치
      t.integer :deaths       #죽음
      t.integer :final_blows  #결정타
      t.float   :kd
      t.float   :kda
      t.float   :healing_done_avr #평균치유
      t.float   :damage_done_avr  #평균피해
      t.timestamps null: false
    end
    add_index :over_daily_data, [:over_user_type_id, :hero_name, :play_type, :created_at], name: "type_id_name_type_date"
    # add_index :over_daily_data, [:play_type, :created_at]
  end
end
