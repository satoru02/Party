module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index
        @notifications = current_user.notifications.where(confirmation: false)
        render json: @notifications
      end

      def show
        @notification = current_user.notifications.find_by(id: params[:id])
        @notification.checked
        render json: @notification
      end
    end
  end
end