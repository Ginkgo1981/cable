class CreateTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :terms, id: :uuid do |t|

      t.string :word
      t.string :ctype
      t.string :pronounce
      t.string :audio_origin
      t.string :audio_url
      t.string :level
      t.string :definition_en
      t.string :definition_cn
      t.timestamps
    end
  end
end
