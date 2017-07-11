class CreateResumeDicInterestTags < ActiveRecord::Migration[5.0]
  def change
    create_table :resume_dic_interest_tags, id: :uuid do |t|
      t.string :intent
      t.string :name
      t.timestamps
    end
  end
end
