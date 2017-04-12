class CreateJiangsuSats < ActiveRecord::Migration[5.0]
  def change
    create_table :jiangsu_sats do |t|

      t.integer :student_id
      t.integer :score_chinese
      t.integer :score_english
      t.integer :score_math
      t.integer :score_sum
      t.string  :kl
      t.string  :km_1
      t.string  :km_2
      t.string :score_km_1
      t.string :score_km_2
      t.timestamps
    end
  end
end
