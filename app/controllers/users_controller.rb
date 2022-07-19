class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @parties = @user.parties.all
  end

  def new; end

  def create
    new_user = User.new(user_params)
    if params[:password] != params[:password_confirmation]
      flash[:error] = 'Password and confirmation do not match!'
      redirect_to '/register'
    elsif new_user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to user_path(id: new_user.id)
    else
      flash[:error] = 'Missing Required Fields'
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      redirect_to user_path(id: user.id)
    else
      flash[:error] = 'Wrong email or password'
      redirect_to '/login'
    end
  end

  private

  def user_params
    params.permit(:name, :password, :email)
  end
end
