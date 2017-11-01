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
#

class StudentsController < ApplicationController

  # before_action :find_user_by_token!, only: [:student_list]
  # before_action :find_entity_by_dsin!, only: [:student_list]
  #
  # def student_list
  #   #设计成 @entity.students加以限制,并参entity的权限与 token相比
  #   # students = Student.includes(:user, :bean, {tags: :bean}).limit(30).reverse_order
  #   students = @entity.followed_by_students.preload(:user, :bean, {tags: :bean}).reverse_order
  #   render json: students,
  #          meta: {code: 0},
  #          each_serializer: StudentSerializer,
  #          include_user: true
  # end

end
