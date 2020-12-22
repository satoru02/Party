module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      def me
        render json: current_user.as_json(only: [:id, :email, :role])
      end

      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find_by(params[:id])
        render json: @user
      end

      def update
      end

      def destroy
      end

      private
    end
  end
end
