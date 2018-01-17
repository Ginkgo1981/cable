require 'singleton'
require 'digest/sha1'

class BaiduClient


  def initialize()


  end

  def access_token
    api_key = Rails.application.config_for('baidu')['AppID']
    secret_key = Rails.application.config_for('baidu')['AppSecret']
    url = "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=#{api_key}&client_secret=#{secret_key}"
    res = Faraday.get(url)
    access_token = JSON(res.body)['access_token']
    puts access_token
    access_token
  end


  def recognize(key)
    # audio_url = '/Users/chenjian/16k.pcm'
    audio_url = "https://images.gaokao2017.cn/#{key}"
    pcm_file_path = "#{Rails.root}/pcm/#{Time.now.strftime('%Y%m%d%H%M%S') + '%04d' % rand(10**4)}.pcm"
    self.convert(audio_url, pcm_file_path)
    remote_file = open(pcm_file_path)
    code64 = Base64.encode64(remote_file.read).gsub("\n", '')
    # size = File.new(audio_url, 'r').stat.size
    url = 'http://vop.baidu.com/server_api'
    json = {
        lan: 'en',
        format:'pcm',
        rate:16000,
        channel:1,
        token:self.access_token,
        cuid:'9e:eb:e8:d4:67:00',
        len:remote_file.stat.size,
        speech:code64
    }
    res = Faraday.post url, JSON.generate(json)
    puts res.body
    text = JSON(res.body)['result'][0]
    puts text
    text
  end



  def convert(origin_audio_url, pcm_file_path)
    # `ffmpeg -y  -i ~/Desktop/audio-1515914691024030.wav  -acodec pcm_s16le -f s16le -ac 1 -ar 16000 16k.pcm`
    command = "ffmpeg -y  -i #{origin_audio_url}  -acodec pcm_s16le -f s16le -ac 1 -ar 16000 #{pcm_file_path}"
    res = `#{command}`
    puts res
  end


  def self.sim_hash(text1, text2)
    a = text1.simhash(:hashbits => 64)
    b = text2.simhash(:hashbits => 64)
    a.hamming_distance_to b
  end
end