class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.integer :user_id
      t.string :form_id
      t.datetime :expired_at
      t.integer :status
      t.string :content
      t.string :from
      t.timestamps
    end
  end
end
