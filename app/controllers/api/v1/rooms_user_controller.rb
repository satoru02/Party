module Api
  module V1
    class RoomsUserController < ApplicationController
      before_action :authorize_access_request!

      def create
        @post = Post.find_by(id: params[:post_id])
        @rooms_user = RoomsUser.new(user_id: params[:user_id], room_id: @post.room.id)
        # if @rooms_user.save!
          # 1.Broadcast
          ActionCable.server.broadcast("Notifications", {
            title: "Entry Approved by host",
            target_user_id: params[:user_id],
          })
          # roomにもbroadcastする

          # 2.mailer
        # end
      end
    end
  end
end