module Api
  module V1
    class PostsController < ApplicationController
      before_action :authorize_access_request!, only: [:show, :create, :edit, :update, :destroy]
      before_action :set_post, only: [:show, :edit, :update, :destroy]

      def index
        if params[:position] === 'top'
          @posts = Post.all.includes(:entries).pager(page: params[:page], per: params[:per_page])
          serializer = PostSerializer.new(@posts.reverse_order, { params: { user_id: params[:user_id] }})
          render json: serializer.serializable_hash.to_json
        elsif params[:position] === 'my_events'
          @posts = Post.all.includes(:entries).where(user_id: params[:user_id])
          serializer = UsersPostSerializer.new(@posts.reverse_order)
          render json: serializer.serializable_hash.to_json
        elsif params[:position] === 'joined_events'
          @user = User.find_by(id: params[:user_id])
          @joined_events = @user.rooms.where("host_id != :user_id", { user_id: @user.id})
          @posts = []
          @joined_events.each do |event|
            post = Post.find_by(id: event.post_id)
            @posts << post
          end
          serializer = JoinedPostSerializer.new(@posts)
          render json: serializer.serializable_hash.to_json
        end
      end

      def show
        serializer = PostSerializer.new(@post)
        render json: serializer.serializable_hash.to_json
      end

      def create
        @post = current_user.posts.build(post_params)
        if @post.save
          Room.create!(name: @post.title, host_id: current_user.id, post_id: @post.id)
          redirect_to root_url
        else
          render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def edit
        if @post.user_id === current_user.id
          serializer = PostSerializer.new(@post)
          render json: serializer.serializable_hash.to_json
        end
      end

      def update
        unless @post.update(post_params)
          render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy!
      end

      def search
        if params[:filter_category] === 'date'
          @filtered_posts = filter_by_date(params[:q])
        end

        if params[:filter_category] === 'title'
          @filterd_posts = filter_by_title(params[:q])
        end

        @pager_filtered_posts = @filtered_posts.pager(page: params[:page], per: params[:per_page])
        serializer = PostSerializer.new(@pager_filtered_posts.reverse_order, { params: { user_id: params[:user_id]}})
        render json: serializer.serializable_hash.to_json
      end

      def popularity
        @filterd_posts = filter_by_popularity
        serializer = PostSerializer.new(@filtered_posts)
        render json: serializer.serializable_hash.to_json
      end

      private

        def set_post
          @post = Post.find_by(id: params[:id])
        end

        def post_params
          params.require(:post).permit(:title, :start_date, :end_date, :content, :category_id, :tag_list, :tools => [])
        end
    end
  end
end
