module Api
  module V1
    class EntriesController < ApplicationController
      before_action :authorize_access_request!

      def create
        @entry = Entry.new(user_id: current_user.id, post_id: params[:post])

        if @entry.save!
          ActionCable.server.broadcast("Notifications", {
            title: "New Request",
            target_user_id: params[:user],
            entry_user_id: @entry.user_id,
            entry_post_id: @entry.post_id,
          })
        end
      end

      private
        def entry_params
          params.require(:entry).permit(:user_id, :post_id, :activated)
        end
    end
  end
end