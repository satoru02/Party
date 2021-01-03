module Api
  module V1
    class RoomsController < ApplicationController
      before_action :authorize_access_request!

      def index
        # @rooms = current_user.rooms.as_json
        # render json: @rooms

        # 仮
        @messages = Message.all
        render json: @messages
      end

      def show
        # @room = Room.find_by(token: params[:resource_token])
        # if @room.authenticated? params[:resource_token]
          # render json: @room.messages
        # end
      end
    end
  end
end