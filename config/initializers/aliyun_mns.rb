Aliyun::Mns.configure do |config|
  config.access_id = Rails.application.config_for('aliyun_mns')['access_key_id']
  config.key = Rails.application.config_for('aliyun_mns')['access_key_secret']
  config.host = Rails.application.config_for('aliyun_mns')['endpoint']
end

# queue = Aliyun::Mns::Queue["test"]
# h = {name: 'jian'}
# queue.send_message JSON(h)
# msg = queue.receive_message
# msg.delete

