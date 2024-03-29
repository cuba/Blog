require 'spec_helper'

describe "Authentication" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let!(:a1) { FactoryGirl.create(:article, :user => user, :content => "Foo") }

  describe "Authorization" do

    ############## NOT SIGNED IN ##############
    ###########################################
    describe "for non-signed-in users" do
      describe "when attempting to visit a protected page" do
        
        ############## ARTICLES (NOT SIGNED IN) ##############
        describe "in the Articles controller" do

          describe "visiting the new article page" do
            before { visit new_article_path }
            it { should have_selector('title', :text => 'Sign in') }
          end

          describe "visiting the edit page" do
            before { visit edit_article_path(a1) }
            it { should have_selector('title', :text => 'Sign in') }
          end

          describe "submitting to the destroy action" do
            before { delete article_path(FactoryGirl.create(:article)) }
            specify { response.should redirect_to(signin_path) }
          end

          describe "visiting article page" do
            before { visit article_path(FactoryGirl.create(:article)) }
            it { should have_selector('textarea', :id => 'comment_content') }
            describe "with invalid information" do
              before { click_button "Comment" }
              it { should have_selector('div.alert.alert-error', :text => '') }
            end

            describe "with valid information" do
              before do
                fill_in "comment_name",    :with => "Someone"
                fill_in "comment_content", :with => "Some Comment"
                click_button "Comment"
              end
              it { should have_selector('div.alert.alert-success', :text => '') }
            end
          end
        end

        ############## COMMENTS (NOT SIGNED IN) ##############
        describe "in the Comments controller" do
        end

        ############## USERS (NOT SIGNED IN) ##############
        describe "in the Users controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }
            it { should have_selector('title', :text => 'Sign in') }
          end

          describe "submitting to the UPDATE action" do
            before { put user_path(user) }
            specify { response.should redirect_to(signin_path) }
          end

          describe "visiting the user index" do
            before { visit users_path }
            it { should have_selector('title', :text => 'Sign in') }
          end

          describe "visiting a users show page" do
            before { visit user_path(user) }
            it { should have_selector('title', :text => 'Sign in') }
          end
        end

        ############## SIGNING IN AFTER VISITING PROTECTED PAGE ##############
        describe "after signing in" do

          before do
            visit edit_user_path(user)
            fill_in "Email",    :with => user.email
            fill_in "Password", :with => user.password
            click_button "Sign in"
          end

          it "should render the desired protected page" do
            page.should have_selector('title', :text => 'Edit user')
          end

          describe "when signing in again" do
            before do
              visit signin_path
              fill_in "Email",    :with => user.email
              fill_in "Password", :with => user.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              page.should have_selector('title', :text => user.username) 
            end
          end
        end
      end
    end

    ############## WRONG USER RIGHTS ##############
    ###############################################
    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, {:email => "wrong@example.com", :username => "Wrong User"}) }
      let(:wrong_article) { FactoryGirl.create(:article, :user => wrong_user, :content => "Wrong Article") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', :text => full_title('Edit user')) }
      end

      describe "visiting Articles#edit page" do
        before { visit edit_article_path(wrong_article) } 
        it { should_not have_selector('title', :text => full_title('Edit Article')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end

  ############## SIGNING IN ##############
  ########################################
  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1',    :text => 'Sign in') }
    it { should have_selector('title', :text => 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', :text => 'Sign in') }
      it { should have_selector('div.alert.alert-error', :text => 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Blog" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "session_email",    :with => user.email
        fill_in "session_password", :with => user.password
        click_button "Sign in"
      end

      it { should have_selector('title', :text => user.username) }
      it { should have_link('Profile', :href => user_path(user)) }
      it { should have_link('Sign out', :href => signout_path) }
      it { should_not have_link('Sign in', :href => signin_path) }
    end
  end
end