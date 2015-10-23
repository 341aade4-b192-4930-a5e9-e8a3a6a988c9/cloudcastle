require 'rest_client'

class StaticPagesController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  #wrap_parameters format: [:json]

  def home
    @user = User.new

  end

  def clear
    User.delete_all

    redirect_to action: 'home', :anchor => 'status'
  end

end

