module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      # ログインが済んでいれば、current_userでpayloadをデコードして、user_idが取り出せる
      def me
        render json: current_user.as_json
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
    end
  end
end
