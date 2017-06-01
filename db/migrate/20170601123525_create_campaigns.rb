class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.integer :university_id
      t.integer :teacher_id
      t.string :address
      t.timestamps
    end
  end
end
