class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.string :name
      t.integer :hot
      t.timestamps
    end
  end
end
