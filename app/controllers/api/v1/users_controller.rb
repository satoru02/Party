module Api
  module V1
    class UsersController < ApplicationController
      def index
        @user = User.all
      end

      def show
      end

      def new
        @user = User.new
      end

      # POST
      def create
      end

      def edit
      end

      # PATCH
      def update
      end

      def destroy
      end

      private
      def user_param
      end
    end
  end
end
