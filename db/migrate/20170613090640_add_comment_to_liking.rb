class AddCommentToLiking < ActiveRecord::Migration[5.0]
  def change
    add_column :likings, :comment, :string
  end
end
