# == Schema Information
#
# Table name: zy_details
#
#  ID          :integer          not null, primary key
#  zydm        :string(50)       not null
#  zymc        :string(50)       not null
#  ccdm        :string(50)       not null
#  goal        :text(65535)
#  claim       :text(65535)
#  trunkcourse :text(65535)
#  course      :text(65535)
#
# Indexes
#
#  PK_GK_zy_Detail  (ID) UNIQUE
#

class ZyDetail < ApplicationRecord
end
