class HomeController < ApplicationController
  def show
    @user = User.new
  end

  def clear
    User.delete_all

    redirect_to action: 'home', :anchor => 'status'
  end
end

