class CreateAttachings < ActiveRecord::Migration[5.0]
  def change
    create_table :attachings, id: :uuid do |t|
      t.uuid :attachable_id
      t.string  :attachable_type
      t.uuid :attachment_id
      t.string  :attachment_type
      t.timestamps
    end
  end
end
