# == Schema Information
#
# Table name: users
#
#  id                           :uuid             not null, primary key
#  cell                         :string(50)
#  sex                          :integer
#  token                        :string(50)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  union_id                     :string
#  subscribe_at                 :datetime
#  unsubscribe_at               :datetime
#  device_info                  :string
#  register_status              :boolean
#  register_at                  :datetime
#  openweb_openid               :string
#  mp_openid                    :string
#  miniapp_openid               :string
#  nickname                     :string
#  country                      :string
#  province                     :string
#  city                         :string
#  headimgurl                   :string
#  language                     :string
#  name                         :string
#  latitude                     :float
#  longitude                    :float
#  type                         :string
#  university                   :string
#  major                        :string
#  industry_tags                :string           is an Array
#  skill_tags                   :string           is an Array
#  notification_message_version :integer          default(0)
#  role                         :integer          default(0)
#  avatar                       :string
#  hr_approved                  :integer          default(0)
#  hr_approved_by               :uuid
#  hr_approved_at               :datetime
#  online_status                :integer          default(0)
#  days_count                   :integer          default(0)
#  words_count                  :integer          default(0)
#  points                       :integer          default(0)
#

class HumanResource < User
  has_many :companies
  has_one :human_resource_info, foreign_key: :user_id
  has_many :hr_resumes, foreign_key: :hr_id
  has_many :resumes, through: :hr_resumes

  scope :with_info, ->{ joins(:human_resource_info)}
end
