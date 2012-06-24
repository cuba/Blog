class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :signed_in_user, :except => []
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :except => []
  
  def dashboard
  end

  def users
    @users = User.paginate(:page => params[:page])
  end

  def articles
    @articles = Article.paginate(:page => params[:page])
  end

  def comments
    @comments = Comment.paginate(:page => params[:page])
  end
end
