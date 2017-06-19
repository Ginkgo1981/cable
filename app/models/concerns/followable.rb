module Followable
  extend ActiveSupport::Concern
  
  included do
    has_many :followed_by,:as => :followable, :class_name => :Following
    has_many :followings, as: :follower

    has_many :following_skycodes, -> { uniq }, :through => :followings, :source => :followable, :source_type => :Skycode
    has_many :following_campaigns, -> { uniq }, :through => :followings, :source => :followable, :source_type => :Campaign

    #campaign
    has_many :followed_by_universities,-> { uniq }, :through => :followed_by, :source => :follower, :source_type => :University
    has_many :following_universities, -> { uniq }, :through => :followings, :source => :followable, :source_type => :University
    #student
    has_many :followed_by_students,-> { uniq }, :through => :followed_by, :source => :follower, :source_type => :Student
    has_many :following_students, -> { uniq }, :through => :followings,  :source => :followable, :source_type => :Student
    #teacher
    has_many :followed_by_teachers,-> { uniq }, :through => :followed_by, :source => :follower, :source_type => :Teacher
    has_many :following_teachers, -> { uniq }, :through => :followings,  :source => :followable, :source_type => :Teacher

    #wishcard
    has_many :followed_by_wishcards,-> { uniq }, :through => :followed_by, :source => :follower, :source_type => :Wishcard
    has_many :following_groups, -> { uniq }, :through => :followings, :source => :followable, :source_type => :Group
  end

end
