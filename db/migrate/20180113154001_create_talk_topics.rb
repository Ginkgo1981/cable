class CreateTalkTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :talk_topics, id: :uuid do |t|
      t.string :talk_date
      t.text :content
      t.timestamps
    end
  end
end
