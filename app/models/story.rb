# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :string(255)
#  content          :text(65535)
#  coverage_img_url :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  teacher_id       :integer
#  university_id    :integer
#  staff_id         :integer
#

class Story < ApplicationRecord
  include BeanFamily
  belongs_to :university, optional: true
  belongs_to :teacher,  optional: true
  belongs_to :staff,  optional: true

  def format
    {
        resource_type: 'Story',
        dsin: self.dsin,
        coverage_img_url: self.coverage_img_url,
        title: self.title,
        description: self.description,
        content: self.content
    }
  end

end
