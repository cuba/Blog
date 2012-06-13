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

require 'spec_helper'

describe User do
  before do
    @user = User.new(
      :username => "Example User",
      :email => "user@example.com",
      :firstname => "Exampe",
      :lastname => "User",
      :password => "foobar",
      :password_confirmation => "foobar")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  it { should respond_to(:password ) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:articles) }
  it { should respond_to(:comments  ) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }

    it { should be_admin }
  end

  it { should be_valid }

  describe "when username is not present " do 
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username address is already taken" do
    before do
      user_with_same_email = User.new(
        :username => @user.username, 
        :email => "user2@example.com",
        :password => "foobar",
        :password_confirmation => "foobar")
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end

  describe "when email format is valid" do
    addresses = %w[user@foo.COM user_US-EN@f.b.org frst.lst@foo.jp a+b@foo.cn]
    addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { should be_valid }
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = User.new(
        :username => "Example User 2",
        :email => @user.email,
        :password => "foobar",
        :password_confirmation => "foobar")
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "when password confirmation is nil" do 
    before {@user.password_confirmation = nil}
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalidpassword")}

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "when password is too short" do 
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end

  describe "when password is too long" do
    before { @user.password = @user.password_confirmation = "a" * 51 }
    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "article associations" do

    before { @user.save }
    let!(:older_article) do 
      FactoryGirl.create(:article, :user => @user, :created_at => 1.day.ago)
    end
    let!(:newer_article) do
      FactoryGirl.create(:article, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have the right articles in the right order" do
      @user.articles.should == [newer_article, older_article]
    end

    it "should destroy associated articles" do
      articles = @user.articles
      @user.destroy
      articles.each do |article|
        Article.find_by_id(article.id).should be_nil
      end
    end
  end

end
