module Api
  module V1
    class PostsController < ApplicationController

      # GET /posts
      def index
        @posts = Post.all
        render json: @posts
      end

      def show
      end

      def search
      end

      private
    end
  end
end
