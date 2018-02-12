class CreatePointActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :point_activities, id: :uuid do |t|
      t.uuid :user_id
      t.integer :points, default: 0
      t.string :activity
      t.string :note
      t.timestamps
    end
  end
end
