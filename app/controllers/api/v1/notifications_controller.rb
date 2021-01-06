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
        @notification.checked

        @entry = Entry.find(@notification.entry_id)
        @post = @entry.post
        @user = @entry.user

        rapping_response = [{
          "Entry" => @entry,
          "Post" => @post,
          "User" => @user }]

        render json: rapping_response

        # Entry
        # if @notification.type === 0
        # entryの情報
        # postの情報
        # userの情報
        # Follow
        # elsif @notification.type === 1
        # else
      end
    end
  end
end