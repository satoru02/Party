module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show]

      # GET /posts
      def index
        @posts = Post.all
        render json: @posts
      end

      # GET /posts/1
      def show
        render json: response_fields(@post.to_json)
      end

      # POST /posts/
      def create
        @post = Post.new(post_params)
        @post.save!
        @post.customize_time
      end

      def edit
      end

      def update
      end

      def destroy
      end

      # response posts on requested query.
      def search
      end

      private

        def set_post
          @post = Post.find_by id: params[:id]
        end

        def post_params
          params.require(:post).permit(:title, :url)
        end

        def response_fields(post)
          post_parse = JSON.parse(post)
          response = post_parse.except('created_at', 'deleted_at', 'updated_at')
          JSON.pretty_generate(response)
        end
    end
  end
end
