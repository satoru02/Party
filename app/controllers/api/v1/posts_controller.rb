module Api
  module V1
    class PostsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_post, only: [:show, :edit, :update]

      def index
        @posts = Post.all.includes(:entries).pager(page: params[:page], per: params[:per_page])
        serializer = PostSerializer.new(@posts.reverse_order, { params: { user_id: params[:user_id] }})
        render json: serializer.serializable_hash.to_json
      end

      def show
        serializer = PostSerializer.new(@post)
        render json: serializer.serializable_hash.to_json
      end

      def create
        @post = current_user.posts.build(post_params)
        if @post.save!
          Room.create!(name: @post.title, host_id: current_user.id, post_id: @post.id)
          @post.import_time
          redirect_to root_url
        end
      end

      def edit
        if @post.user_id === current_user.id
          serializer = PostSerializer.new(@post)
          render json: serializer.serializable_hash.to_json
        end
      end

      def update
        @post.update_attributes(post_params)
      end

      def destroy
      end

      def search
        filter_posts(params[:q])
        @pager_filtered_posts = @filtered_posts.pager(page: params[:page], per: params[:per_page])
        serializer = PostSerializer.new(@pager_filtered_posts)
        render json: serializer.serializable_hash.to_json
      end

      private

        def set_post
          @post = Post.find_by(id: params[:id])
        end

        def post_params
          params.require(:post).permit(:title, :user_id, :category_id, :tag_list)
        end
    end
  end
end
