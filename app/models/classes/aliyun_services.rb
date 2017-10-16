require 'singleton'
class AliyunServices
  def self.get_business_card qiniu_key
    begin
      captcha_url = "https://images.gaokao2017.cn/#{qiniu_key}?imageMogr2/thumbnail/500x800%3E"
      code64 = Base64.encode64(open(captcha_url).read)
      conn = Faraday.new(:url => 'http://dm-57.data.aliyun.com/rest/160601/ocr/ocr_business_card.json')
      res = conn.post do |req|
        req.headers['Authorization'] = 'APPCODE cc487596a73d478aba58d90613061aea'
        req.body = {inputs: [ { image: { dataType: 50, dataValue: code64 } } ] }.to_json
      end
      data= JSON(res.body)['outputs'][0]['outputValue']['dataValue']
      hr = JSON(data).symbolize_keys
      hr_json = {
          addr: hr[:addr][0],
          company: hr[:company][0],
          name: hr[:name],
          department: hr[:department][0],
          email: hr[:email][0],
          tel_work: hr[:tel_work][0],
          tel_cell: hr[:tel_cell][0],
          title: hr[:title][0],
      }
      puts "=====  #{hr_json}"
      hr_json
    rescue => e
      puts "#{e}"
      raise CableException::BussinessCardReadError(e.to_s)
    end
  end
end