# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  cell          :string(50)
#  passwd        :string(255)
#  salt          :string(255)
#  name          :string(255)      default("")
#  sex           :integer
#  email         :string(50)
#  token         :string(50)
#  identity_id   :string(50)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  identity_type :string(255)
#

class User < ApplicationRecord

  has_many :sended_messages, class_name: Message
  belongs_to :identity, polymorphic: true, dependent: destroy

  has_many :followings
  has_many :following_teachers, :source => :followable, :through => :followings, :source_type => :Teacher



  has_many :bookmarking
  has_many :bookmarking_messages, :source => :bookmarkable, :through => :bookamrkings, :source_type => :Message

  def offline
    pp '======== offline ==========='
  end



  def online
    pp ' ========== online =========='


  end
end
