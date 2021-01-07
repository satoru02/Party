module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @notifications = current_user.notifications
        render json: @notifications
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

          rapping_response = [{
            "notification" => @notification,
            "entry" => @entry,
            "post" => @post,
            "user" => @user }]

          render json: rapping_response

        elsif @notification.classification === 'entryResponse'

          @entry_response = EntryResponse.find_by(id: @notification.entry_response_id)

          rapping_response = [{
            "notification" => @notification,
            "entry_response" => @entry_response
          }]

          render json: rapping_response

        elsif @notification.classification === 'message'

          @message = Message.find_by(id: @notification.message_id)

          rapping_response = [{
            "notification" => @notification,
            "message" => @message
          }]

          render json: rapping_response

        end
      end
    end
  end
end