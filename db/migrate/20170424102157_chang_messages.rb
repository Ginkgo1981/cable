class ChangMessages < ActiveRecord::Migration[5.0]
  def change

    remove_column :messages, :user_id
    remove_column :messages, :sender_id

    add_column :messages, :student_id, :integer
    add_column :messages, :teacher_id, :integer
    add_column :messages, :staff_id, :integer
    add_column :messages, :university_id, :integer
    add_column :messages, :direction, :string
  end
end
