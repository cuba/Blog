class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :edit, :update, :show]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :only => [:destroy]

  def index
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  def create
    @user = User.new(params[:user])
    if (@user.save)
      sign_in @user
      flash[:success] = "You have successfully registered your account!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #user defined when calling the :current_user before filter
  end

  def update
    #user defined when calling the :current_user before filter
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
