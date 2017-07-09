class AddTagByToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :tagged_by, :uuid
  end
end
