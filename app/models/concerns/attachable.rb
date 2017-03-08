# -*- coding: utf-8 -*-
module Attachable               # 可以附着附件的
  extend ActiveSupport::Concern
  
  included do
    has_many :attachings, as: :attachable

    has_many :attached_photos, :through => :attachings, :source => :attachment, :source_type => :Photo # 

    def attachments
      self.attachings.map{ |i| i.attachment }
    end
  end

end
