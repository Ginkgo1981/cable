class ChangeTaggedByToInteger < ActiveRecord::Migration[5.0]
  def change

    change_column :tags, :tagged_by, :integer
  end
end
