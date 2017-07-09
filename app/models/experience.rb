# == Schema Information
#
# Table name: experiences
#
#  id         :uuid             not null, primary key
#  resume_id  :uuid
#  title      :string
#  content    :text
#  images     :text             is an Array
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Experience < ApplicationRecord
  belongs_to :resume
  default_scope -> {order(created_at: :desc)}
  def format
    {
        id: self.id,
        title: self.title,
        content: self.content,
        images: self.images,
        start_date: self.start_date&.strftime("%Y-%m-%d"),
        end_date: self.end_date&.strftime("%Y-%m-%d")
    }
  end


end
