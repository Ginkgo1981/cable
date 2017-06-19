class CreateAskcards < ActiveRecord::Migration[5.0]
  def change
    create_table :askcards do |t|

      t.timestamps
    end
  end
end
