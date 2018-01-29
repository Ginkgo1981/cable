# == Schema Information
#
# Table name: user_books
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  book_id    :uuid
#  begin_at   :date
#  end_at     :date
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserBook < ApplicationRecord

  belongs_to :user
  belongs_to :book
end
