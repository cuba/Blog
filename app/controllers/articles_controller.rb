class ArticlesController < ApplicationController
  before_filter :signed_in_user,          :only => [:new, :edit, :update, :destroy]
  before_filter :correct_user,            :only => [:edit, :update, :destroy]
  before_filter :admin_user,              :only => [:new, :destroy]

  def index
    @articles = Article.paginate(:page => params[:page])
  end

  def new
    @article = current_user.articles.build(params[:article])
  end

  def create
    @article = current_user.articles.build(params[:article])
    if @article.save
      flash[:success] = "Article created!"
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    @user = @article.user
  end

  def preview
    @article = params[:article]
    respond_to do |format|
      format.js do
        render :ajax => "test"
      end

      #format.js{ render :preview do |page|
       # page.replace_html 'two_on_two', 'Hello world!'
      #end}
    end
  end

  def edit
    @article = Article.find(params[:id])
    @user = @article.user
  end

  def update
    #user defined when calling the :current_user before filter
    if @article.update_attributes(params[:article])
      flash[:success] = "Article updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article Deleted"
    redirect_to articles_path
  end

  private

    def correct_user
      @article = current_user.articles.find_by_id(params[:id])
      redirect_to root_path if @article.nil?
    end
end
