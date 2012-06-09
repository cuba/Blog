class Article < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  default_scope :order => 'articles.created_at DESC'

  validates(
    :user_id, 
    :presence => true
    )

  validates(
    :content, 
    :presence => true,
    :length => { :maximum => 150 }
    )
end
