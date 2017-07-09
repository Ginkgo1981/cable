# == Schema Information
#
# Table name: message_bookmarkings
#
#  id         :uuid             not null, primary key
#  message_id :uuid
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageBookmarking < ApplicationRecord
end
