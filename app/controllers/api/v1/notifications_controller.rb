module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index

        if params[:position] === 'top'
          @notifications = current_user.notifications.where(confirmation: false)
          @notifications_part = @notifications.pager(page: params[:page], per: params[:per_page])
          serializer = TopNotificationSerializer.new(@notifications_part.reverse_order)

        else params[:position] === 'index'
          @notifications = current_user.notifications
          @notifications_part = @notifications.pager(page: params[:page], per: params[:per_page])
          serializer = NotificationSerializer.new(@notifications_part.reverse_order)
        end

        render json: serializer.serializable_hash.to_json
      end

      def show
        @notification = current_user.notifications.find_by(id: params[:id])

        if @notification.confirmation === false
          ActionCable.server.broadcast("Notifications", {
            title: "Notification is readen.",
            target_user_id: @notification.user_id,
            condition: "read"
          })
        end

        @notification.checked

        if @notification.classification === 'entry'
          @entry = Entry.find_by(id: @notification.entry_id)
          @user = @entry.user
          @post = @entry.post
          serializer = NotificationSerializer.new(@notification, { params: { entry: @entry, post: @post, user: @user } })
        elsif @notification.classification === 'entryResponse'
          @entry_response = EntryResponse.find_by(id: @notification.entry_response_id)
          @post = Post.find_by(id: @entry_response.post_id)
          @room = @post.room
          @user = User.find_by(id: @post.user_id)
          serializer = NotificationSerializer.new(@notification, { params: { entry_response: @entry_response, room: @room, user: @user } })
        elsif @notification.classification === 'message'
          @message = Message.find_by(id: @notification.message_id)
          @user = User.find_by(id: @message.user_id)
          @room = Room.find_by(id: @message.room_id)
          serializer = NotificationSerializer.new(@notification, { params: { message: @message, user: @user, room: @room } })
        end

        render json: serializer.serializable_hash.to_json
      end
    end
  end
end