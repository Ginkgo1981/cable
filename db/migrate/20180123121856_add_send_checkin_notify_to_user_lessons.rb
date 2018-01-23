class AddSendCheckinNotifyToUserLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :user_lessons,:send_checkin_notify, :integer, default: 0
  end
end
