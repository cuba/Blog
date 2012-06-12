class StaticPagesController < ApplicationController
  def home
    @article = Article.first
    redirect_to @article
  end

  def help
  end

  def about
  end

  def contact
  end
end
