require 'pry'
class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @user = User.find(session[:user_id])
  end
  def show
    @attraction = Attraction.find(params[:id])
    @user = User.find(session[:user_id])
  end
  def ride
  #  binding.pry
    @user = User.find(session[:user_id])
    @attraction = Attraction.find(params[:attraction][:id].to_i)
    if @user.height < @attraction.min_height && @user.tickets < @attraction.tickets
      redirect_to user_path(@user), notice: "You are not tall enough to ride the #{@attraction.name}. You do not have enough tickets to ride the #{@attraction.name}."
    elsif @user.height < @attraction.min_height
      redirect_to user_path(@user), notice: "You are not tall enough to ride the #{@attraction.name}"
    elsif @user.tickets < @attraction.tickets
      redirect_to user_path(@user), notice: "You do not have enough tickets to ride the #{@attraction.name}"
    else
      @user.tickets -= @attraction.tickets
      @user.nausea += @attraction.nausea_rating
      @user.happiness += @attraction.happiness_rating
      @user.save
      redirect_to user_path(@user), notice: "Thanks for riding the #{@attraction.name}!"
    end
  end
  def new
    @attraction = Attraction.new
  end
  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end
  def edit
    @attraction = Attraction.find(params[:id])
  end
  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  private
  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :min_height, :happiness_rating, :nausea_rating)
  end

end
