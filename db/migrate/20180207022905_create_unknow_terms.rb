class CreateUnknowTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :unknow_terms do |t|
      t.string :word
      t.timestamps
    end
  end
end
