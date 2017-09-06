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

class SkillSerializer < ApplicationSerializer
  attributes :id, :resume_id, :title, :content, :category, :images


end
