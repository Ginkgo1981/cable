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

class Campaign < ApplicationRecord
  belongs_to :bucket, :polymorphic => true
  has_many :user_campaigns
  has_many :users, through: :user_campaigns
  has_many :campaign_details

  has_many :campaign_activities
  has_many :user_campaign_progresses

  def self.mock_create_one
    book = Book.find '9e18725d-885c-4547-af22-e7983208e7a7'
    Campaign.create! name: '假如给我三天光明',
                 bucket: book,
                 start_at: Time.now.to_date,
                 end_at: (Time.now + 24.days).to_date,
                 duration: 24,
                 sell_state: 1
  end

  def format
    {
        id: id,
        bucket: bucket.try(:format),
        start_at: start_at.strftime('%Y-%m-%d'),
        end_at: end_at.strftime('%Y-%m-%d'),
        name: name,
        details: campaign_details.map(&:format),
        tags: tags,
        user_campaign_progresses_count: user_campaign_progresses.count,
        users_count: users.count
    }
  end
end