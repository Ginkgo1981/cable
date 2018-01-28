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
#

class UsersController < ApplicationController

  def get_student_list
    count = Student.count
    students = Student.all.includes(resumes: [:educations,:experiences,:skills,:honors]).page(params[:page].to_i + 1).per(20)
    render json: students,
           meta: {code: 0, count: count},
           each_serializer: StudentSerializer
  end



  def update_hr
    #todo update info
    hr = HumanResource.find params[:id]
    hr.hr_approved = params[:hr_approved].to_i
    hr.save!
    render json: { code: 0, message: 'approved' }
  end

  def get_hr_list
    count = HumanResource.with_info.count
    hrs = HumanResource.with_info.includes(:human_resource_info).page(params[:page].to_i + 1).per(20)
    render json: hrs,
           meta: {code: 0, count: count},
           each_serializer: HumanResourceSerializer
  end


  def get_student
    s = Student.find_by id:params[:id]
    render json: {code: 0, data: s.format}
  end


  def delete_user
    s =  Student.find_by id: params[:id]
    s.destroy if s
    render json: {code: 0, message: 'succ'}
  end

  def delete_hr
    s =  HumanResource.find_by id: params[:id]
    s.destroy if s
    render json: {code: 0, message: 'succ'}
  end

end
