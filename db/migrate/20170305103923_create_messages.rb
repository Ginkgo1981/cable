class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.text     'content'
      t.uuid  'user_id'
      t.timestamps
    end
  end
end
