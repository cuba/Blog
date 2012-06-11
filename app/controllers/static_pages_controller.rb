class StaticPagesController < ApplicationController
  def home
    @article = Article.first
    @user = @article.user
  end

  def help
  end

  def about
  end

  def contact
  end
end
