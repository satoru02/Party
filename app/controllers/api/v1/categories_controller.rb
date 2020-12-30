module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_category, only: [:show]

      def index
        @categories = Category.all
        render json: @categories
      end

      def show
        # binding.prys
        @category_posts = @category.posts.pager(page: params[:page], per: params[:per_page])
        render json: @category_posts.to_json
      end

      # ====================================================
      def drama
      end

      def sf
      end

      def comedy
      end

      def romance
      end

      def documentary
      end

      def japan
      end

      def foreign
      end
      # ========================================================

      private

        def set_category
          @category = Category.find_by(id: params[:id])
        end

        def response_fields(category)
          parsed_category = JSON.parse(category)
          response = parsed_category.except('created_at', 'deleted_at', 'updated_at')
          JSON.pretty_generate(response)
        end
    end
  end
end