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

class HumanResourceInfo < ApplicationRecord
  belongs_to :human_resource, foreign_key: :user_id

  def format
    {
        id: self.id,
        addr: self.addr,
        company: self.company,
        department: self.department,
        email: self.email,
        name: self.name,
        tel_cell: self.tel_cell,
        tel_work: self.tel_work,
        title: self.title,
        source: self.source
    }
  end


end
