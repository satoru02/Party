module Api
  module V1
    class RoomsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @rooms = current_user.rooms.as_json
        render json: @rooms
      end

      def show
        @room = Room.find_by(resource_token: params[:token])
        if @room.authenticated? params[:token]
          render json: @room.messages
          # ユーザーの名前も返したい。
        end
      end
    end
  end
end