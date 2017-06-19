# -*- coding: utf-8 -*-
module Likable
  extend ActiveSupport::Concern
  
  included do
    has_many :likings, :as => :likable
    has_many :liked_by, :through => :likings, :class_name => :User, :source => :user

  end

  def like_comment(user, comment)
    self.likings.create! user: user,
                         comment: comment
  end
end
