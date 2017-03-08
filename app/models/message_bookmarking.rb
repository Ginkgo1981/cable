# == Schema Information
#
# Table name: message_bookmarkings
#
#  id         :integer          not null, primary key
#  message_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageBookmarking < ApplicationRecord
end
