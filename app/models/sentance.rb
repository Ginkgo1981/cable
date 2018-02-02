# == Schema Information
#
# Table name: sentances
#
#  id         :uuid             not null, primary key
#  term_id    :uuid
#  en         :string
#  zh         :string
#  ord        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sentance < ApplicationRecord

  belongs_to :term




end
