module Api
  module V1
    class RoomsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @rooms = current_user.rooms
        serializer = RoomSerializer.new(@rooms)
        render json: serializer.serializable_hash.to_json
      end

      def show
        @room = Room.find_by(resource_token: params[:token])
        @user = User.find_by(id: params[:user_id])
        if @room.authenticated?(params[:token]) && @room.users.include?(@user)
          serializer = RoomSerializer.new(@room, { params: { messages: @room.messages, users: @room.users} })
          render json: serializer.serializable_hash.to_json
        end
      end
    end
  end
end