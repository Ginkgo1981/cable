class AddMatchesToTalkThread < ActiveRecord::Migration[5.0]
  def change
    add_column :talk_threads, :matches, :text, array: true
  end
end
