module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:posts, :show, :edit, :update, :destroy]

      def me
        if params[:position] === 'activation'
          serializer = InitialUserSerializer.new(current_user)
          render json: serializer.serializable_hash.to_json
        elsif params[:position] === 'login'
          serializer = UserSerializer.new(current_user)
          render json: serializer.serializable_hash.to_json
        end
      end

      def index
        @users = User.all
        serializer = UserSerializer.new(@users)
        render json: serializer.serializable_hash.to_json
      end

      def show
        options={}
        options[:include] = [:posts]
        serializer = UserSerializer.new(@user, options)
        render json: serializer.serializable_hash.to_json
      end

      def edit
        serializer = UserSerializer.new(@user)
        render json: serializer.serializable_hash.to_json
      end

      def update
        @user.update!(user_params)
        @user.attach_avatar(params[:file_name])
        serializer = UserSerializer.new(current_user)
        render json: serializer.serializable_hash.to_json
      end

      def destroy
        @user.destroy!
      end

      def posts
        serializer = UserSerializer.new(@user)
        render json: serializer.serializable_hash.to_json
      end

      def following
        @user = User.find(params[:id])
        @following_users = @user.following
        serializer = FollowingSerializer.new(@following_users)
        render json: serializer.serializable_hash.to_json
      end

      def followers
        @user = User.find(params[:id])
        @user_followers = @user.followers
        serializer = FollowingSerializer.new(@user_followers)
        render json: serializer.serializable_hash.to_json
      end

      private

        def user_params
          params.require(:user).permit(
            :email, :about, :web_url, :name, :username, :youtube_url, :facebook_url, :instagram_url, :filmarks_url, :location
          )
        end

        def set_user
          @user = User.includes(:posts).find(params[:id])
        end
    end
  end
end
