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

class HonorSerializer < ApplicationSerializer
  attributes :id, :resume_id, :title, :content, :start_date, :end_date, :images



end
