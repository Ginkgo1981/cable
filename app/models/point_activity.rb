# == Schema Information
#
# Table name: point_activities
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  points     :integer          default(0)
#  activity   :string
#  note       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PointActivity < ApplicationRecord
  belongs_to :user
  after_create :calculate_points
  scope :at_today, -> {where('created_at >= ? and created_at <= ?', Time.now.beginning_of_day, Time.now.end_of_day)}



  def calculate_points
    user.points = user.points +  self.points
    user.save!
  end


  def format
    {
        points: points,
        activity: activity,
        note:  created_at.strftime('%Y年%m月%d日') + note
    }
  end




end
