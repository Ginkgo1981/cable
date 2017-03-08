module Commentable
  extend ActiveSupport::Concern
  
  included do
    # has_one :message_thread, as: :commentable, dependent: :destroy
    # has_many :messages, through: :message_thread
    # accepts_nested_attributes_for :message_thread, allow_destroy: true
    #
    # after_create :create_message_thread
  end

end
