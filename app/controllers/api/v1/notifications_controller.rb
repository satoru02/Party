module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @notifications = current_user.notifications.pager(page: params[:page], per: params[:per_page])
        serializer = NotificationSerializer.new(@notifications)
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
          @post = @entry.post
          @user = @entry.user
          serializer = NotificationSerializer.new(@notification, { params: { entry: @entry, post: @post, user: @user } })
          render json: serializer.serializable_hash.to_json

        elsif @notification.classification === 'entryResponse'

          @entry_response = EntryResponse.find_by(id: @notification.entry_response_id)
          serializer = NotificationSerializer.new(@notification, { params: { entry_response: @entry_response } })
          render json: serializer.serializable_hash.to_json

        elsif @notification.classification === 'message'

          @message = Message.find_by(id: @notification.message_id)
          serializer = NotificationSerializer.new(@notification, { params: { message: @message } })
          render json: serializer.serializable_hash.to_json

        end
      end
    end
  end
end