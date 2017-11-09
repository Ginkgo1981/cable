# == Schema Information
#
# Table name: hr_resumes
#
#  id         :uuid             not null, primary key
#  hr_id      :uuid
#  resume_id  :uuid
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class HrResumeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
