# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  taggable_id   :integer
#  taggable_type :string(255)
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tagged_by     :string(255)
#

class Tag < ApplicationRecord

  belongs_to :taggable, :polymorphic => true

  def format_detail
    {
        id: self.id,
        name: self.name
    }
  end

end
