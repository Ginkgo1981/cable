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
#  online_status                :boolean
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
#

class StudentSerializer < ApplicationSerializer
  attributes :id, :cell, :name, :headimgurl, :avatar, :nickname, :province, :city, :created_at, :resume_score, :university, :major,:industry_tags, :skill_tags

  def created_at
    object.created_at.strftime('%m月%d日 %H:%M')
  end

  def resume_score
    object.resumes[0].score
  end

  # has_one :user , if: -> {instance_options[:include_user]}
  # has_many :tags, if: -> {instance_options[:include_tags]}
  # attribute :user,  if: -> {instance_options[:include_user]}
  # attributes :user,only: [:id, :token]

  # def user
  #   object.user&.format
  # end

end
