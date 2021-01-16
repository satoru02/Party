module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:posts, :show, :edit, :update]

      def me
        serializer = UserSerializer.new(current_user)
        render json: serializer.serializable_hash.to_json
      end

      def index
        @users = User.all
        serializer = UserSerializer.new(@users)
        render json: serializer.serializable_hash.to_json
      end

      def show
        serializer = UserSerializer.new(@user)
        render json: serializer.serializable_hash.to_json
      end

      def edit
        serializer = UserSerializer.new(@user)
        render json: serializer.serializable_hash.to_json
      end

      def update
        @user.avatar.attach(params[:avatar])
        # @user.update_attributes(user_params)
      end

      def destroy
      end

      def posts
        serializer = UserSerializer.new(@user)
        render json: serializer.serializable_hash.to_json
      end

      private

        def user_params
          params.require(:user).permit(:email, :about, :web_url, :name, :username, :youtube_url, :facebook_url, :instagram_url, :filmarks_url, :location, :avatar)
        end

        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
