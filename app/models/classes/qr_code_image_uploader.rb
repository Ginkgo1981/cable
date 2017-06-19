class QRCodeImageUploader < CarrierWave::Uploader::Base
  storage :qiniu
end