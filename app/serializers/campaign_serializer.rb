# == Schema Information
#
# Table name: campaigns
#
#  id             :uuid             not null, primary key
#  bucket_id      :uuid
#  bucket_type    :string
#  start_at       :date
#  end_at         :date
#  duration       :integer
#  sell_state     :integer
#  completed_days :integer
#  missed_days    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string
#  tags           :text             is an Array
#

class CampaignSerializer < ApplicationSerializer
  attributes :id, :dsin, :name, :note
end
