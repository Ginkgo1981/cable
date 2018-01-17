class AddRecognizeResultToTopicThread < ActiveRecord::Migration[5.0]
  def change
    add_column :talk_threads, :recognize_result, :string
  end
end
