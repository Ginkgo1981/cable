class CreateTalkThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :talk_threads,  id: :uuid do |t|
      t.uuid :talk_topic_id
      t.uuid :user_id
      t.string :audio_url
      t.integer :score
      t.timestamps
    end
  end
end
