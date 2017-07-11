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

class StorySerializer < ApplicationSerializer
  attributes :id, :dsin, :title, :description, :content, :coverage_img_url
end
