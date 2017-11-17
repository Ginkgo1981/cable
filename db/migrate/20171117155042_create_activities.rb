class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities, id: :uuid do |t|
      t.uuid :user_id
      t.string :openid
      t.string :msg_type
      t.string :event
      t.string :content
      t.timestamps
    end
  end
end
