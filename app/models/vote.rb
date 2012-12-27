class Vote < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :farmpost, :counter_cache => true
  belongs_to :user
  
  validates :user_id, :uniqueness => {:scope => :farmpost_id}
end