require 'spec_helper'

describe "Article pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "article creation" do
    describe "as an admin user" do
      before do
        sign_in admin
        visit new_article_path
      end
      describe "with invalid information" do

        it "should not create a article" do
          expect { click_button "Post" }.should_not change(Article, :count)
        end

        describe "error messages" do
          before { click_button "Post" }
          it { should have_content('error') } 
        end
      end

      describe "with valid information" do

        before { fill_in 'article_content', :with => "Lorem ipsum" }
        it "should create a article" do
          expect { click_button "Post" }.should change(Article, :count).by(1)
        end
      end
    end
  end
end