class CreateQrCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :qr_codes, id: :uuid do |t|
      t.string   "image"
      t.uuid  "codeable_id"
      t.string   "codeable_type"
      t.timestamps
    end
  end
end
