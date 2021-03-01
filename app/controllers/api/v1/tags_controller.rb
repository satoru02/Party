module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: [:show]

      def index
        @tags = ActsAsTaggableOn::Tag.most_used(10)
        serializer = TagSerializer.new(@tags)
        render json: serializer.serializable_hash.to_json
      end

      def show
        @post = Post.tagged_with(@tag.name)
        @paged_post = @post.pager(page: params[:page], per: params[:per_page])
        serializer = PostSerializer.new(@paged_post.reverse_order, { params: { user_id: params[:user_id]}})
        render json: serializer.serializable_hash.to_json
      end

      private

      def set_tag
        @tag = ActsAsTaggableOn::Tag.find_by(name: params[:name])
      end
    end
  end
end