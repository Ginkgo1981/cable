class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms, id: :uuid do |t|
      t.uuid :user_id
      t.string :form_id
      t.datetime :expired_at
      t.integer :status
      t.string :content
      t.string :from
      t.timestamps
    end
  end
end
