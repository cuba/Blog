require 'spec_helper'

describe Comment do
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:article_id) }
  it { should respond_to(:article) }

  let(:user) { FactoryGirl.create(:user) }
  let(:commenter) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.create(:article, :user => user) }
  let!(:comment) { FactoryGirl.create(:comment, :user => commenter, :article => article ) }

  subject { comment }


  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(:user_id => commenter.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
