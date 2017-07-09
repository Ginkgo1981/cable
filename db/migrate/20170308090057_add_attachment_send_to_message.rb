class AddAttachmentSendToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :type, :string
    add_column :messages, :receiver_id, :uuid
    add_column :messages, :attachment_id, :uuid
    add_column :messages, :attachment_type, :string
  end
end
