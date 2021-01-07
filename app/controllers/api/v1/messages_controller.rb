module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authorize_access_request!

      def show
        @message = Message.find_by(id: params[:id])
        render json: @message
      end
    end
  end
end