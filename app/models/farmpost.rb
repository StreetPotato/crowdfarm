class Farmpost < ActiveRecord::Base
  attr_accessible :concept, :tags, :target, :title, :user_id, :votes_count
  attr_accessor :current_user
  belongs_to :user
  has_many :votes
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 } 
  validates :concept, presence: true, length: { maximum: 75 }
  validates :tags, presence: true, length: { maximum: 100 }
  validates :target, presence: true, 
                     :numericality => { :only_integer => true, 
                                        :greater_than_or_equal_to => 50,
                                        :less_than_or_equal_to => 200 }

  
  default_scope order: 'farmposts.votes_count DESC'

end
