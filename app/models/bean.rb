# == Schema Information
#
# Table name: beans
#
#  id               :uuid             not null, primary key
#  bean_family_id   :uuid
#  bean_family_type :string
#  dsin             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Bean < ApplicationRecord
  before_save :generate_dsin
  belongs_to :bean_family, :polymorphic => true, dependent: :destroy


  def self.find_by_dsin dsin
    bean = Bean.find_by dsin: dsin
    bean &&  bean.bean_family
  end

  def generate_dsin
    self.dsin = SecureRandom.urlsafe_base64
  end
end
