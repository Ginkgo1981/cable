class AddMoreToTalkTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :talk_topics, :banner, :string
    add_column :talk_topics, :chinese, :string
    add_column :talk_topics, :note, :string
  end
end
