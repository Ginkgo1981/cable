class CreateMajorHots < ActiveRecord::Migration[5.0]
  def change
    create_table :major_hots do |t|
      t.string :name
      t.integer :hot, default: 0
      t.timestamps
    end
  end
end
