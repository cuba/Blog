class StaticPagesController < ApplicationController
  def home
    @article = Article.last
    @user = @article.user
  end

  def help
  end

  def about
  end

  def contact
  end
end
