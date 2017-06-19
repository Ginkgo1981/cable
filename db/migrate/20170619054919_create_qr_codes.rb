class CreateQrCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :qr_codes do |t|
      t.string   "image"
      t.integer  "codeable_id"
      t.string   "codeable_type"
      t.timestamps
    end
  end
end
