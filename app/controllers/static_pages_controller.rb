require 'rest_client'

class StaticPagesController < ApplicationController

  def home
    @user = User.new

    @users_rating1 = User.where(status: User.statuses[:completed]).order(rating1: :desc).limit(Settings.n).all

    @users_rating2 = User.where(status: User.statuses[:completed]).order(rating2: :desc).limit(Settings.n).all

    @users_status = User.order(created_at: :desc).limit(Settings.n).all
  end

  def clear
    User.delete_all

    redirect_to action: 'home', :anchor => 'status'
  end

  def add
    @user = User.new(user_params)

    if !@user.valid? 
      flash[:adduser_form_error] = 'Имя пользователя может содержать латинские буквы, числа или дефисы, и быть не более 39 символов.'

      redirect_to action: 'home', :anchor => 'adduser'

      return
    end

    if User.exists?(:name => @user.name.downcase)
      flash[:adduser_form_error] = 'Данные по пользователю с таким именем уже собирались.'

      redirect_to action: 'home', :anchor => 'adduser'

      return
    end

    @user.wait!
    @user.save

    #@user.delay.execute
    @user.execute

    redirect_to action: 'home', :anchor => 'status'
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end

