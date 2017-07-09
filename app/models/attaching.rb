# == Schema Information
#
# Table name: attachings
#
#  id              :uuid             not null, primary key
#  attachable_id   :uuid
#  attachable_type :string
#  attachment_id   :uuid
#  attachment_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attaching < ApplicationRecord

  belongs_to :attachment, :polymorphic => true
  belongs_to :attachable, :polymorphic => true

end
