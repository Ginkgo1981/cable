class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.string :cell
      t.string :code
      t.integer :status
      t.timestamps :expired_at
      t.timestamps
    end
  end
end
