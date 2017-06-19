::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = 'S5ZafL5apxUHtW2KzwUtCgB7WqQYSZkKMvWzzOpv'
  config.qiniu_secret_key    = 'O5J64ysn3x__J94mj324nevhe9pf4iV7k8_0pJPi'
  config.qiniu_bucket        = 'gaokao'
  config.qiniu_bucket_domain = 'images.gaokao2017.cn'
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = 'https'
end