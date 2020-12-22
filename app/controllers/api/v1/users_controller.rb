module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find_by(params[:id])
      end

      # POST
      def create
        user = User.new(user_params)
        if user.save
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          tokens = session.login
          response.set_cookie(
            JWTSessions.access_cookie,
            value: tokens[:access],
            httponly: true,
            secure: Rails.env.production?,
            path: "/"
          )
          render json: { csrf: tokens[:csrf] }
        else
          render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
        end
      end

      # PATCH
      def update
      end

      def destroy
      end

      private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
    end
  end
end
