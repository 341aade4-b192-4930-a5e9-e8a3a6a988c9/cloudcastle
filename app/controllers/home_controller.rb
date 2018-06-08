class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token  

  def show
    @user = User.new
  end

  def clear
    User.delete_all

    redirect_to action: 'home', :anchor => 'status'
  end
end

