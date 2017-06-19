# == Schema Information
#
# Table name: wishcards
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  cities        :text(65535)
#  universities  :text(65535)
#  majors        :text(65535)
#  introdution   :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  count_of_like :integer          default(0)
#  nickname      :string(255)
#  headimgurl    :string(255)
#

class Wishcard < ApplicationRecord
  include Followable
  include BeanFamily
  include Likable
  belongs_to :user
  serialize :cities, Array
  serialize :universities, Array
  serialize :majors, Array


  # def format
  #   {
  #       dsin: self.dsin,
  #       user: self.user.format_basic,
  #       cities: self.cities,
  #       universities: self.universities,
  #       majors: self.majors,
  #       introdution: introdution,
  #       # liked_by: self.liked_by.map{|u| u.format_basic},
  #       likings: self.likings.reverse_order.map{|l| l.format},
  #       count_of_like: self.count_of_like,
  #       following_groups: self.following_groups.map{|g| {group_id: g.group_id}}
  #   }
  # end





end
