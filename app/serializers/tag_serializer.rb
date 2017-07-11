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

class TagSerializer < ApplicationSerializer
  attributes :id, :name, :dsin, :tagged_by

end
