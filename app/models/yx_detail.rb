# == Schema Information
#
# Table name: yx_details
#
#  ID      :integer          not null, primary key
#  yxdm    :string(5)        not null
#  yxmc    :string(64)       not null
#  dq      :string(50)
#  xxdz    :string(50)
#  xxwz    :string(50)
#  xxdh    :string(50)
#  xxjj    :text(65535)
#  zsjz    :text(65535)
#  zxxx    :text(65535)
#  brief   :text(65535)
#  IsMaked :integer
#
# Indexes
#
#  PK_GK_sys_SchoolDetail  (ID) UNIQUE
#

class YxDetail < ApplicationRecord



end
