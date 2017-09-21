# == Schema Information
#
# Table name: resume_dic_experiences
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  industry_id   :uuid
#  industry_name :string
#  name          :string
#  content       :string
#

require 'test_helper'

class ResumeDicExperienceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
