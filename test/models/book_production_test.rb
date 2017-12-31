# == Schema Information
#
# Table name: book_productions
#
#  id              :uuid             not null, primary key
#  book_id         :uuid
#  title           :string
#  lesson_start_at :date
#  lesson_end_at   :date
#  sell_start_at   :datetime
#  sell_end_at     :datetime
#  duration        :integer          default(0)
#  objectives      :text             default([]), is an Array
#  requirements    :text             default([]), is an Array
#  limit           :integer
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sell_state      :integer          default(0)
#

require 'test_helper'

class BookProductionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
