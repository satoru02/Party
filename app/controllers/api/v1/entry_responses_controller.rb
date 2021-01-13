module Api
  module V1
    class EntryResponsesController < ApplicationController
      before_action :authorize_access_request!

      def show
        @entry_response = EntryResponse.find_by(id: params[:id])
        render json: @entry_response
      end
    end
  end
end