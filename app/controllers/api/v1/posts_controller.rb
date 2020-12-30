module Api
  module V1
    class PostsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_post, only: [:show, :edit, :update]

      def index
        @posts = Post.pager(page: params[:page], per: params[:per_page])
        render json: @posts
      end

      def show
        render json: response_fields(@post.to_json)
      end

      def create
        @post = current_user.posts.build(post_params)
        if @post.save!
          @post.import_time
          redirect_to root_url
        end
      end

      def edit
        if @post.user_id === current_user.id
          render json: response_fields(@post.to_json)
        end
      end

      def update
        @post.update_attributes(post_params)
      end

      def destroy
      end

      def search
        filter_posts(params[:q])
        filter_users(params[:q])
        render json: rapping_response(@filtered_users, @filtered_posts)
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

        def rapping_response(user, post)
          rapping_response = { "Filtered_Users" => user, "Filtered_Posts" => post }
        end
    end
  end
end
