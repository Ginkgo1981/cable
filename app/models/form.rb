# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  form_id    :string(255)
#  expired_at :datetime
#  status     :integer
#  content    :string(255)
#  from       :string(255)
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
