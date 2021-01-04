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
        @user = User.find_by(id: params[:user_id])
        if @room.authenticated?(params[:token]) && @room.users.include?(@user)
          render json: @room.messages
        end
      end
    end
  end
end