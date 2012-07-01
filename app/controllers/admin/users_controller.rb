class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :signed_in_user, :except => []
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :except => []
  
  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.updating_password = false
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to [:admin, @user]
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to [:admin, users_path]
  end
end