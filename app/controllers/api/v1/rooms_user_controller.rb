module Api
  module V1
    class RoomsUserController < ApplicationController
      before_action :authorize_access_request!

      def create
        @post = Post.find_by(id: params[:post_id])
        @rooms_user = RoomsUser.new(user_id: params[:user_id], room_id: @post.room.id)

        if current_user.id == @post.room.host_id
          @rooms_user.save!

          answer = check_answer params[:answer]
          EntryResponse.create(user_id: params[:user_id], post_id: params[:post_id], answer: answer)
          ActionCable.server.broadcast("Notifications", {
            title: "Entry Approved by host",
            target_user_id: params[:user_id],
          })
        end
      end

      private

        def check_answer params
          if params === "authorize"
            true
          else
            false
          end
        end
    end
  end
end