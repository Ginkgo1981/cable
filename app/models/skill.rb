# == Schema Information
#
# Table name: skills
#
#  id         :uuid             not null, primary key
#  resume_id  :uuid
#  title      :string
#  content    :string
#  category   :string
#  images     :text             is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ApplicationRecord
  belongs_to :resume

  default_scope -> {order(created_at: :desc)}

  def format
    {
        id: self.id,
        title: self.title,
        content: self.content,
        images: self.images
    }
  end
end
