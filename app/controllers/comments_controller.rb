class CommentsController < ApplicationController
  before_filter :signed_in_user,          :only => [:new, :edit, :update, :destroy]
  before_filter :correct_user,            :only => [:edit, :update, :destroy]
  #before_filter :admin_user,              :only => []

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment successfull!"
      redirect_to article_path(@article)
    else
      @user = @article.user
      render 'articles/show'
    end
  end

  def show
  end

  def preview
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_path if @comment.nil?
    end
end
