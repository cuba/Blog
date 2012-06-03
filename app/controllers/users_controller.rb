class UsersController < ApplicationController
  def index
  end
  
  def new
    #new_user = User.new()
  end

  def show
    @user = User.find(params[:id])
  end
end
