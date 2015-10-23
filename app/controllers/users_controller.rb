class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token  

  def create
    @user = User.new(user_params)

    if !@user.valid? 
      adduser_form_error = 'Имя пользователя может содержать латинские буквы, числа или дефисы, и быть не более 39 символов.'
      render json: { :error_message => adduser_form_error }, status: :unprocessable_entity 

      return
    end

    if User.exists?(:name => @user.name.downcase)
      adduser_form_error = 'Данные по пользователю с таким именем уже собирались.'
      render json: { :error_message => adduser_form_error }, status: :unprocessable_entity 

      return
    end

    @user.wait!
    @user.save

    @user.delay.execute

    render json: @user, status: :created
  end

  def by_rating1
    @users_rating1 = User.where(status: User.statuses[:completed]).order(rating1: :desc).limit(Settings.n).all
    render :json => @users_rating1
  end

  def by_rating2
    @users_rating2 = User.where(status: User.statuses[:completed]).order(rating2: :desc).limit(Settings.n).all
    render :json => @users_rating2
  end

  def index
    if !params.has_key?(:orderby)
      @users_status = User.order(created_at: :desc).limit(Settings.n).all
      render :json => @users_status

      return
    end

    if params[:orderby] == 'rating1'
      by_rating1

      return
    end

    if params[:orderby] == 'rating2'
      by_rating2

      return
    end
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
