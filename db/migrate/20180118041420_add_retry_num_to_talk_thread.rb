class AddRetryNumToTalkThread < ActiveRecord::Migration[5.0]
  def change
    add_column :talk_threads, :retry_count, :integer, default: 0
  end
end
