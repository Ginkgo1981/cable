class AddGeoToUniversity < ActiveRecord::Migration[5.0]
  def change
    # t.hstore :setting
    add_column :universities, :geo, :string, array: true
  end
end
