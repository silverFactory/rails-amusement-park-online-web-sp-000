require 'pry'
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    #binding.pry
    redirect_to user_path(@user)
  end
  def show

    if session[:user_id]
    #  binding.pry
      @user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :admin, :password)
  end
end
