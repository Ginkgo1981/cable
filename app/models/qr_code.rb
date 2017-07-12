# == Schema Information
#
# Table name: qr_codes
#
#  id            :uuid             not null, primary key
#  image         :string
#  codeable_id   :uuid
#  codeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class QrCode < ApplicationRecord
  belongs_to :codeable, polymorphic: true
  mount_base64_uploader :image, QRCodeImageUploader

  def self.create_from(entity)
    record = entity.create_qr_code
    raw_image = RQRCode::QRCode.new(entity.dsin).as_png(size: 240)
    file = FilelessIO.new("#{entity.dsin}.png", raw_image.to_s)
    record.image = file
    record.save
    record
  end


end