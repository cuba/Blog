require 'spec_helper'

describe "Admin Authentication" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:a1) { FactoryGirl.create(:article, :user => user, :content => "Foo") }

  describe "Authorization" do

    ############## ADMIN RIGHTS ##############
    ##########################################
    describe "as non-admin user" do
      let(:non_admin) { FactoryGirl.create(:user) }
      before { sign_in non_admin }

      describe "submitting a DELETE request to the Articles#destroy action" do
        before { delete article_path(a1) }
        specify { response.should redirect_to(root_path) }
      end

      describe "submitting a GET request to the Articles#new action" do
        before { get new_article_path }
        specify { response.should redirect_to(root_path) }
      end

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end

      describe "visiting the new article page" do
        before { visit new_article_path }
        it { should_not have_selector('title', :text => 'Edit Article') }
      end
    end
  end
end