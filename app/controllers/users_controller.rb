class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token  

  def create
    user = User.new(user_params)

    if !user.valid?
      error_message = 'The name should contain only latin letters, numbers or hyphens. It should be less than 40 characters.'
      render json: { error_message: error_message }, status: :unprocessable_entity

      return
    end

    if User.exists?(:name => user.name.downcase)
      error_message = 'This user has already been processed.'
      render json: { error_message: error_message }, status: :unprocessable_entity

      return
    end

    user.update!(status: :wait)

    user.save

    UserInfoWorker.perform_async(user.id)

    render json: user, status: :created
  end

  def index
    if !params.has_key?(:order_by)
      render json: User.by_created_at.limited
    end

    if params[:order_by] == 'rating1'
      puts User.by_rating1.limited
      render json: User.by_rating1.limited
    end

    if params[:order_by] == 'rating2'
      render json: User.by_rating2.limited
    end
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
