class AddLanLogToUniversity < ActiveRecord::Migration[5.0]
  def change
    remove_column :universities, :geo
    add_column :universities, :latitude, :float
    add_column :universities, :longitude, :float
  end
end
