class CreateUniversities < ActiveRecord::Migration[5.0]
  def change
    create_table :universities, id: :uuid do |t|
      t.string  "name"
      t.string  "code"
      t.string  "city"
      t.string  "address"
      t.string  "website"
      t.string  "tel"
      t.text    "brief"
      t.timestamps
    end
  end
end
