module Api
  module V1
    class RoomsController < ApplicationController
      def index
        @messages = Message.all
        render json: @messages
      end
    end
  end
end