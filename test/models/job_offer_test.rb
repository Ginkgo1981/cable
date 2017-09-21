# == Schema Information
#
# Table name: job_offers
#
#  id          :uuid             not null, primary key
#  user_job_id :uuid
#  note        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class JobOfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
