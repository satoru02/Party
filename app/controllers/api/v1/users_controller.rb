module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find_by(params[:id])
        render json: @user
      end

      # PATCH
      def update
      end

      def destroy
      end

      private
    end
  end
end
