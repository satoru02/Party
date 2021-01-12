module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_category, only: [:show]

      def index
        @categories = Category.all
        serializer = CategorySerializer.new(@categories)
        render json: serializer.serializable_hash.to_json
      end

      def show
        serializer = CategorySerializer.new(@category, { params: { post: @category.posts }})
        render json: serializer.serializable_hash.to_json
      end

      private

        def set_category
          @category = Category.find_by(id: params[:id])
        end
    end
  end
end