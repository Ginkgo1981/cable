class DeleteUselessColumnFromStudent < ActiveRecord::Migration[5.0]
  def change
    remove_column :students,  :province
    remove_column :students,  :city
  end
end
