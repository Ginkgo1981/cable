# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :string(255)
#  content          :text(65535)
#  coverage_img_url :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Story < ApplicationRecord



  def format
    {
        id: self.id,
        title: self.title,
        description:  self.description,
        content: self.content,
        user_id: self.user_id
    }
  end


end
