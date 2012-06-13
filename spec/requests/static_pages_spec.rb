require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', :text => heading) }
    it { should have_selector('title', :text => full_title(page_title)) }
  end
  
  describe "Home Page:" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:a1) { FactoryGirl.create(:article, :user => user, :title => "Foo") }
    before { visit root_path }
    let (:heading) { 'Foo' }
    let (:page_title) {'Foo'}

    describe "should have comments fields" do
      before { visit article_path(a1) }
      it { should have_selector('textarea', :id => 'comment_content') }
    end

    it_should_behave_like "all static pages"
  end

  describe "About Page:" do
    before { visit about_path }
    let (:heading) { 'About Us' }
    let (:page_title) {'About Us'}
    it_should_behave_like "all static pages"
  end

  describe "Contact Page:" do
    before { visit contact_path }
    let (:heading) { 'Contact' }
    let (:page_title) {'Contact'}
    it_should_behave_like "all static pages"
  end

end
