require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h1', :text => 'Sign up')}
    it { should have_selector('title', :text => full_title('Sign up'))}
  end

  describe "Profile Page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', :text => user.username) }
    it { should have_selector('title', :text => user.username) }
  end

  describe "signup" do
    before {visit signup_path }
    let(:submit) { "Create my Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', :text => 'Sign up') }
        it { should have_selector('div.alert.alert-error', :text => 'error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_username",              :with => "Test.User"
        fill_in "user_email",                 :with => "Test.User@example.com"
        fill_in "user_firstname",             :with => "Test"
        fill_in "user_lastname",              :with => "User"
        fill_in "user_password",              :with => "foobar"
        fill_in "user_password_confirmation", :with => "foobar"
      end

      it "should create a user" do
        expect {click_button submit }.to change(User, :count).by(1) 
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('test.user@example.com') }

        it { should have_selector('title', :text => user.username) }
        it { should have_success_message('You have successfully registered your account!') }
        it { should have_link('Sign out') }

        describe "followed by signout" do
        before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    :text => "Update your profile") }
      it { should have_selector('title', :text => "Edit user") }
      #it { should have_link('change', :href => 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_error_message('error') }
    end

    describe "with valid information" do
      let(:new_username)  { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_firstname) { "New" }
      let(:new_lastname) { "Name"}
      before do
        fill_in "user_username",              :with => new_username
        fill_in "user_email",                 :with => new_email
        fill_in "user_firstname",             :with => new_firstname
        fill_in "user_lastname",              :with => new_lastname
        fill_in "user_password",              :with => user.password
        fill_in "user_password_confirmation", :with => user.password
        click_button "Save changes"
      end

      it { should have_selector('title', :text => new_username) }
      it { should have_success_message('Profile updated') }
      it { should have_link('Sign out', :href => signout_path) }
      specify { user.reload.username.should  == new_username }
      specify { user.reload.email.should == new_email }
    end

  end

end
