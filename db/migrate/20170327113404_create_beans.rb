class CreateBeans < ActiveRecord::Migration[5.0]
  def change
    create_table :beans do |t|
      t.integer :bean_family_id
      t.string  :bean_family_type
      t.string  :dsin
      t.timestamps
    end
  end
end
