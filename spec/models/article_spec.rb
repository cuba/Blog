require 'spec_helper'

describe Article do
  let(:user) { FactoryGirl.create(:user) }
  before { @article = user.articles.build(
    :title => "lorem Ipsum", 
    :content => "Lorem ipsum dit alor",
    :abstract => "Lorem ipsum dit"
    ) }

  subject { @article }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @article.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Article.new(:user_id => user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @article.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @article.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @article.content = "a" * 10001 }
    it { should_not be_valid }
  end
end
