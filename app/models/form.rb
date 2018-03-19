# == Schema Information
#
# Table name: forms
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  form_id    :string
#  expired_at :datetime
#  status     :integer
#  content    :string
#  from       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Form < ApplicationRecord

  belongs_to :user
  before_create :set_expired_at

  default_scope -> {order('created_at')}

  def set_expired_at
    self.expired_at = DateTime.now + 7.days
  end


  def self.daily_promotion
    wechat_mini_app_client = WechatMiniAppClient.new('wxbeddbe15b456a582', 'd043773699dbba089d49592984a2e638')
    Form.pluck(:user_id).uniq.each do |user_id|
      user = User.find_by id: user_id
      if user
        form = user.forms.first
        template =
            {
                'touser': user.miniapp_openid,
                'template_id': '3qbH911jUMZpHzx9_0akjcr6wWM64IhYtZ3Pd37OdjA',
                'page': 'pages/exam-friend-defense-page/exam-friend-defense-page',
                'form_id': form.form_id,
                'data': {
                    'keyword1': {
                        'value': '你收到一个好友挑战'
                    },
                    'keyword2': {
                        'value': '你的好朋友喊你去答题',
                    }
                }
            }
        form.destroy
        wechat_mini_app_client.send_template_message template
      end
    end
  end
end
