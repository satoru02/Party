module Api
  module V1
    class TagsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @tags = ActsAsTaggableOn::Tag.most_used(10)
        serializer = TagSerializer.new(@tags)
        render json: serializer.serializable_hash.to_json
      end

      def show
        @tag = ActsAsTaggableOn::Tag.find_by(id: params[:id])
        @post = Post.tagged_with(@tag.name)
        serializer = PostSerializer.new(@post)
        render json: serializer.serializable_hash.to_json
      end
    end
  end
end