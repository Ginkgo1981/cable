class AddAudioToTalkTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :talk_topics, :audio_url, :string
  end
end
