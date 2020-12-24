module Api
  module V1
    class PostsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_post, only: [:show]

      # GET api/v1/posts
      def index
        @posts = Post.pager(page: params[:page], per: params[:per_page])
        render json: @posts
      end

      # GET api/v1/posts/1
      def show
        render json: response_fields(@post.to_json)
      end

      # POST api/v1/posts/
      def create
        @post = current_user.posts.build(post_params)
        if @post.save!
          @post.import_time
          redirect_to root_url
        end
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
          @post = Post.find_by(id: params[:id])
        end

        def post_params
          params.require(:post).permit(:title, :url, :user_id)
        end

        def response_fields(post)
          post_parse = JSON.parse(post)
          response = post_parse.except('created_at', 'deleted_at', 'updated_at')
          JSON.pretty_generate(response)
        end
    end
  end
end
