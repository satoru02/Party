module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index

        if params[:position] === 'top'
          @notifications = current_user.notifications.where(confirmation: false)
          @notifications.pager(page: params[:page], per: params[:per_page])
          serializer = TopNotificationSerializer.new(@notifications.reverse_order)
          render json: serializer.serializable_hash.to_json

        else params[:position] === 'index'
          @notifications = current_user.notifications.where(confirmation: true)
          @notifications.pager(page: params[:page], per: params[:per_page])
          serializer = NotificationSerializer.new(@notifications.reverse_order)
          render json: serializer.serializable_hash.to_json

        end
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
          render json: serializer.serializable_hash.to_json

        elsif @notification.classification === 'entryResponse'

          @entry_response = EntryResponse.find_by(id: @notification.entry_response_id)
          @post = Post.find_by(id: @entry_response.post_id)
          @room = @post.room
          @user = User.find_by(id: @post.user_id)
          serializer = NotificationSerializer.new(@notification, { params: { entry_response: @entry_response, room: @room, user: @user } })
          render json: serializer.serializable_hash.to_json

        elsif @notification.classification === 'message'

          @message = Message.find_by(id: @notification.message_id)
          @user = User.find_by(id: @message.user_id)
          @room = Room.find_by(id: @message.room_id)
          serializer = NotificationSerializer.new(@notification, { params: { message: @message, user: @user, room: @room } })
          render json: serializer.serializable_hash.to_json

        end
      end
    end
  end
end