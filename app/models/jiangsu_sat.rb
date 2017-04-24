# == Schema Information
#
# Table name: jiangsu_sats
#
#  id            :integer          not null, primary key
#  student_id    :integer
#  score_chinese :integer
#  score_english :integer
#  score_math    :integer
#  score_sum     :integer
#  kl            :string(255)
#  km_1          :string(255)
#  km_2          :string(255)
#  score_km_1    :string(255)
#  score_km_2    :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class JiangsuSat < ApplicationRecord
  include BeanFamily
  belongs_to :student

end

