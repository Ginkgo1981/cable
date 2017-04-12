# == Schema Information
#
# Table name: attachings
#
#  id              :integer          not null, primary key
#  attachable_id   :integer
#  attachable_type :string(255)
#  attachment_id   :integer
#  attachment_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attaching < ApplicationRecord

  belongs_to :attachment, :polymorphic => true
  belongs_to :attachable, :polymorphic => true

end
