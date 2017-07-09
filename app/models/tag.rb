# == Schema Information
#
# Table name: tags
#
#  id            :uuid             not null, primary key
#  taggable_id   :uuid
#  taggable_type :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tagged_by     :uuid
#

class Tag < ApplicationRecord
  include BeanFamily
  belongs_to :taggable, :polymorphic => true


end
