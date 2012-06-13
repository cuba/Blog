class Article < ActiveRecord::Base
  attr_accessible :content, :title, :abstract
  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates_associated :comments
  
  default_scope :order => 'articles.created_at DESC'

  validates(
    :user_id, 
    :presence => true
    )

  validates(
    :title, 
    :presence => true
    )

  validates(
    :abstract,
    :length => { :maximum => 500 }
    )

  validates(
    :content, 
    :presence => true,
    :length => { :maximum => 10000 }
    )
end
