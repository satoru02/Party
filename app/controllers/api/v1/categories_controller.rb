module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show]

      def index
        @categories = Category.all.includes(:posts)
        serializer = CategorySerializer.new(@categories)
        render json: serializer.serializable_hash.to_json
      end

      def show
        @category_posts = @category.posts.pager(page: params[:page], per: params[:per_page])
        serializer = PostSerializer.new(@category_posts.reverse_order, { params: { user_id: params[:user_id]}})
        render json: serializer.serializable_hash.to_json
      end

      private

        def set_category
          @category = Category.find_by(slug: params[:slug])
        end
    end
  end
end