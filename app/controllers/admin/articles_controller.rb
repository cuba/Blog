class Admin::ArticlesController < ApplicationController
  layout 'admin'
  before_filter :signed_in_user, :except => []
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :except => []
  
  def index
    @articles = Article.paginate(:page => params[:page])
  end

  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @comments = @article.comments.paginate(:page => params[:page])
  end

  def edit
    @article = Article.find(params[:id])
    @user = @article.user
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:success] = "Article updated"
      redirect_to [:admin, @article]
    else
      render 'edit'
    end
  end
end