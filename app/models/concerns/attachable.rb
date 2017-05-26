# -*- coding: utf-8 -*-
module Attachable               # 可以附着附件的
  extend ActiveSupport::Concern
  
  included do
    has_many :attachings, as: :attachable
    # has_many :attachments, :through => :attachings
    has_many :attached_photos, :through => :attachings, :source => :attachment, :source_type => :Photo
    has_many :attached_stories,:through => :attachings, :source => :attachment, :source_type => :Story
    has_many :attached_majors, :through => :attachings, :source => :attachment, :source_type => :Major

    def attachments
      self.attachings.map{ |i| i.attachment }
    end

    def set_attachments(attachs)
      attachs.each do |a|
        self.attached_photos  << a if a.is_a? Photo
        self.attached_majors  << a if a.is_a? Major
        self.attached_stories << a if a.is_a? Story
      end
    end
  end

end
