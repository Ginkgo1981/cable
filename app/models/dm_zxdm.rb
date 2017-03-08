# == Schema Information
#
# Table name: dm_zxdms
#
#  xxdm :string(12)       not null, primary key
#  sxdm :string(9)        not null
#  xxmc :string(100)      not null
#
# Indexes
#
#  PK_GK_DM_zxdm_1  (xxdm) UNIQUE
#

class DmZxdm < ApplicationRecord
end
