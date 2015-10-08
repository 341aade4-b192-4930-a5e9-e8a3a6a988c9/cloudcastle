require 'rest_client'

#require "#{Rails.root.to_s}/lib/NewsletterJob.rb"

class StaticPagesController < ApplicationController
  helper StandartTableHelper
  def home
    @user = User.new

    @users_rating1 = User.where(status: User.statuses[:completed]).order(rating1: :desc).limit(Settings.n).all

    @users_rating2 = User.where(status: User.statuses[:completed]).order(rating2: :desc).limit(Settings.n).all

    @users_status = User.order(created_at: :desc).limit(Settings.n).all
  end

  def add
    #User.delete_all

    @user = User.new(user_params)

    @user.wait!

    @user.save
    
    @user.delay.execute

    redirect_to action: 'home', :anchor => 'status'
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end

