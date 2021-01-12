module Api
  module V1
    class RoomsUserController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_post, only: [:create]
      before_action :check_user, only: [:create]

      def create

        @room = @post.room
        @validated_user_id = RoomsUser.check_duplicate_user(@room.id, params[:user_id])
        @rooms_user = RoomsUser.new(user_id: @validated_user_id, room_id: @room.id)

        @answer = check_answer(params[:answer])
        @entry = Entry.find_by(id: params[:entry_id])

        if @answer === true

          @entry.activate
          @rooms_user.save!
          EntryResponse.create(user_id: params[:user_id], post_id: params[:post_id], answer: @answer)
          ActionCable.server.broadcast("Notifications", {
            title: "Entry Approved by host",
            target_user_id: params[:user_id],
          })

          @message = Message.find_by(room_id: @rooms_user.room_id, user_id: @rooms_user.user_id)
          ActionCable.server.broadcast("room_channel_#{@room.resource_token}", {
            user: @message.user.username,
            time: @message.created_at
          })

        elsif @answer === false

          @entry.deactivate
          EntryResponse.create(user_id: params[:user_id], post_id: params[:post_id], answer: @answer)
          ActionCable.server.broadcast("Notifications", {
            title: "Entry Declined by host",
            target_user_id: params[:user_id],
          })
        end
      end

      private

        def set_post
          @post = Post.find_by(id: params[:post_id])
        end

        def check_user
          current_user.id == @post.room.host_id
        end

        def check_answer(params)
          if params === "authorize"
            true
          elsif params === "decline"
            false
          end
        end
    end
  end
end