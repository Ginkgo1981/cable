# == Schema Information
#
# Table name: followings
#
#  id              :uuid             not null, primary key
#  followable_id   :uuid
#  followable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  follower_id     :uuid
#  follower_type   :uuid
#

class Following < ApplicationRecord
  belongs_to :follower, :polymorphic => true
  belongs_to :followable, :polymorphic => true



  # after_create_commit :create_following_succ_message
  # private
  # def create_following_succ_message
  #   teacher = self.followable
  #   #to student
  #   PointMessage.create! user: self.user,
  #                        content: "#{self.user.name} 你已成功关注老师 #{teacher.user.name}",
  #                        receiver: self.user
  #   #to teacher
  #   PointMessage.create! user: self.user,
  #                        content: "#{teacher.user.name}, 学生#{self.user.name}关注你",
  #                        receiver: teacher.user
  # end

end
