# -*- coding: utf-8 -*-
module BeanFamily
  extend ActiveSupport::Concern

  delegate :dsin, to: 'self.bean', allow_nil: true

  included do
    after_create {self.create_bean}
    has_one :bean, as: :bean_family, dependent: :destroy
  end

  module ClassMethods

    def find_by_dsin(dsin)
      "#{self.name}".constantize.joins(:bean).where( beans: {dsin: dsin } ).take
    end

  end


end
