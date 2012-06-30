# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :username, :password, :password_confirmation
  has_secure_password

  attr_accessor :ignore_password_validation

  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates(:username, 
    :presence => true, 
    :length => { :maximum => 50 },
    :uniqueness => { :cases_sensitive => false }
    )

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, 
    :presence => true,
    :length => { :maximum => 50 }, 
    :format => { :with => VALID_EMAIL_REGEX},
    :uniqueness => { :cases_sensitive => false }
    )

  validates(:password, 
    :presence => true,
    :length => {:minimum => 6, :maximum => 50}
    )

  validates( :password_confirmation, 
    :presence => true,
    :length => {:minimum => 6, :maximum => 50}
    )



  private
    def should_validate_password?
      new_record?
    end

    def create_remember_token
      self.remember_token = SecureRandom.base64.tr("+/", "-_")
    end
end
