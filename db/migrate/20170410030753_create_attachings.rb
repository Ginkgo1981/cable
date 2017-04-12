class CreateAttachings < ActiveRecord::Migration[5.0]
  def change
    create_table :attachings do |t|
      t.integer :attachable_id
      t.string  :attachable_type
      t.integer :attachment_id
      t.string  :attachment_type
      t.timestamps
    end
  end
end
