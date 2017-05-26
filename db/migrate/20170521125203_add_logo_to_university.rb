class AddLogoToUniversity < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :logo, :string
  end
end
