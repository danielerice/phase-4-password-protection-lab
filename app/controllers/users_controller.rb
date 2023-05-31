class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        user = User.find_by(id: session[:user_id])
        render json: user, status: :ok
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def unprocessable_entity_response invalid
        render json: {error: 'Record Invalid'}, status: :unprocessable_entity
    end

    def record_not_found_response invalid
        render json: {error: 'User Not Found'}, status: :not_found
    end
end
