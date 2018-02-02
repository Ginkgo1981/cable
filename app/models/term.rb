# == Schema Information
#
# Table name: terms
#
#  id            :uuid             not null, primary key
#  word          :string
#  ctype         :string
#  pronounce     :string
#  audio_origin  :string
#  audio_url     :string
#  level         :string
#  definition_en :string
#  definition_cn :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Term < ApplicationRecord
  has_many :sentances, dependent: :destroy
end
