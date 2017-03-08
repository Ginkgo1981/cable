# -*- coding: utf-8 -*-
module Likable
  extend ActiveSupport::Concern
  
  included do
    has_many :likings, :as => :likable
    has_many :liked_by, :through => :likings, :class_name => :User, :source => :user

  end

end
