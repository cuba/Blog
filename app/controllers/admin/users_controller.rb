class Admin::UsersController < ApplicationController
  #layout 'admin'
  before_filter :signed_in_user, :except => []
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :except => []
  
  def index
    @users = User.paginate(:page => params[:page])
  end
end