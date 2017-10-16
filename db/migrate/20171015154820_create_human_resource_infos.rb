class CreateHumanResourceInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :human_resource_infos,id: :uuid do |t|
      t.uuid :user_id
      t.string :addr
      t.string :company
      t.string :department
      t.string :email
      t.string :name
      t.string :tel_cell
      t.string :tel_work
      t.string :title
      t.string :source
      t.timestamps
    end
  end
end
