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

class Reader < User

  def membership
    {
        id: self.id,
        cell: self.cell,
        token: self.token,
        type: self.type,
        union_id: self.union_id,
        name: self.name,
        nickname: self.nickname,
        sex: self.sex,
        province: self.province,
        city: self.city,
        headimgurl: self.headimgurl,
        avatar: self.avatar,
        latitude: self.latitude,
        longitude: self.longitude,
        role: self.role,
        user_lessons_count: self.user_lessons.count

    }
  end


end
