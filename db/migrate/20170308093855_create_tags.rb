class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.integer  "taggable_id"
      t.string   "taggable_type"
      t.string   "name"
      t.timestamps
    end
  end
end
