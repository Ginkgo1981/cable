class CreateInvitings < ActiveRecord::Migration[5.0]
  def change
    create_table :invitings, id: :uuid do |t|
      t.uuid :inviter_id
      t.uuid :invitee_id
      t.uuid :group_id
      t.timestamps
    end
  end
end
