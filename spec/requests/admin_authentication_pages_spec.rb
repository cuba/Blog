require 'spec_helper'

describe "Authorization" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:a1) { FactoryGirl.create(:article, :user => user, :content => "Foo") }

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

    describe "showing admin sidebar" do
      before { visit root_path }
      it { should_not have_selector('ul#sidebar')}
    end

    describe "submitting a GET request to" do
      describe "Admin::Users:index action" do
        before { get admin_users_path }
        specify { response.should redirect_to(root_path) }
      end

      describe "Admin::Articles:index action" do
        before { get admin_articles_path }
        specify { response.should redirect_to(root_path) }
      end

      describe "Admin::Comments:index action" do
        before { get admin_comments_path }
        specify { response.should redirect_to(root_path) }
      end
    end
    
  end

  describe "as admin user" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { sign_in admin }

    describe "showing admin sidebar" do
      before { visit root_path }
      it { should have_selector('ul#sidebar')}
    end

    describe "submitting a GET request to" do
      describe "Admin::Users:index action" do
        before { get admin_users_path }
        specify { response.should render_template('admin/users/index') }
      end

      describe "Admin::Articles:index action" do
        before { get admin_articles_path }
        specify { response.should render_template('admin/articles/index') }
      end

      describe "Admin::Comments:index action" do
        before { get admin_comments_path }
        specify { response.should render_template('admin/comments/index') }
      end
    end
  end
end