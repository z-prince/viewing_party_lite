class UsersController < ApplicationController
  def show
    @user = current_user
    @parties = @user.parties.all
  end

  def new; end

  def create
    new_user = User.new(user_params)
    if params[:password] != params[:password_confirmation]
      flash[:error] = 'Password and confirmation do not match!'
      redirect_to '/register'
    elsif new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.email}!"
      redirect_to '/dashboard'
    else
      flash[:error] = 'Missing Required Fields'
      redirect_to '/register'
    end
  end

  def discover
    @user = current_user
  end

  private

  def user_params
    params.permit(:name, :password, :email)
  end
end
