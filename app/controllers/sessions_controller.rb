class SessionsController < ApplicationController
  def index
  end
  def new
    @user = User.new
  end
  def create
    #raise params.inspect
    session[:user_id] = User.find(params[:user][:name]).id
    redirect_to user_path(session[:user_id])
  end
  def destroy
    session[:user_id] = nil
  end
end
