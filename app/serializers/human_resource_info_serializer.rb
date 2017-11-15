# == Schema Information
#
# Table name: human_resource_infos
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  addr       :string
#  company    :string
#  department :string
#  email      :string
#  name       :string
#  tel_cell   :string
#  tel_work   :string
#  title      :string
#  source     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HumanResourceInfoSerializer < ApplicationSerializer
  attributes :id, :addr, :company,    :department, :email,      :name,       :tel_cell,   :tel_work,   :title
end
