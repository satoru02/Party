module Api
  module V1
    class EntriesController < ApplicationController
      before_action :authorize_access_request!

      # ①vue header top call
      # ②vue /notifications call
      def index
        # @entries = []
        # current_user.posts.each do |v|
        #   @entries << v.entries
        # end

        # if params[:top]
        #   render json: @entries.where(confirmation: false)
        # else
        #   render json: @entries
        # end
        # render json: @entries.where(confirmation: false)
      end

      def show
        # @entry = Entry.find_by(id: params[:id])
        # @entry.checked
        # render json: @entry
      end

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