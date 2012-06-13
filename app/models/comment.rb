class Comment < ActiveRecord::Base
  attr_accessible :content, :email, :name
  belongs_to :article
  belongs_to :user

  validates(
    :content, 
    :presence => true,
    :length => { :maximum => 500 }
    )

  default_scope :order => 'comments.created_at DESC'
end
