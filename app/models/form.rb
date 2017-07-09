# == Schema Information
#
# Table name: forms
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  form_id    :string
#  expired_at :datetime
#  status     :integer
#  content    :string
#  from       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Form < ApplicationRecord

  belongs_to :user
  before_create :set_expired_at

  def set_expired_at
    self.expired_at = DateTime.now + 7.days
  end


end
