module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :edit, :update]

      def me
        render json: current_user.as_json
      end

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def edit
        render json: @user
      end

      def update
        @user.update_attributes(user_params)
      end

      def destroy
      end

      private

        def user_params
          params.require(:user).permit(:email, :about, :web_url, :name, :username, :youtube_url, :facebook_url, :instagram_url, :filmarks_url)
        end

        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
