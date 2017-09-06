# == Schema Information
#
# Table name: honors
#
#  id         :uuid             not null, primary key
#  resume_id  :uuid
#  title      :string
#  content    :text
#  start_date :datetime
#  end_date   :datetime
#  images     :text             is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Honor < ApplicationRecord
  belongs_to :resume
  default_scope -> {order(created_at: :desc)}

  def format
    start_date = self.start_date.strftime('%Y-%m-%d') rescue nil
    end_date = self.end_date.strftime('%Y-%m-%d') rescue nil
    {
        id: self.id,
        title: self.title,
        content: self.content,
        images: self.images,
        start_date: start_date,
        end_date: end_date
    }

  end
end
