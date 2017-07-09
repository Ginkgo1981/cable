class CreateBeans < ActiveRecord::Migration[5.0]
  def change
    create_table :beans, id: :uuid do |t|
      t.uuid :bean_family_id
      t.string  :bean_family_type
      t.string  :dsin
      t.timestamps
    end
  end
end
