# == Schema Information
#
# Table name: cells
#
#  id         :integer          not null, primary key
#  cell       :string(255)
#  code       :string(255)
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cell < ApplicationRecord
  before_create :generate_code

  def send_sms
    url  = 'https://sms.yunpian.com/v2/sms/single_send.json'
    data = {
        apikey: '507db1bb0bf856d4871f194cee599339',
        mobile: self.cell,
        text: "【霖跃科技】您的验证码是#{self.code}"
    }
    # resp = Faraday.post url, data
    true
  end


  def generate_code
    self.code = '1234'
    # self.code = SecureRandom.random_number(10000).to_s.ljust(4, '0')
  end

end
