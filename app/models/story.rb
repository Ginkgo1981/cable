# == Schema Information
#
# Table name: stories
#
#  id               :uuid             not null, primary key
#  title            :string
#  description      :string
#  content          :text
#  coverage_img_url :string
#  user_id          :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
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
