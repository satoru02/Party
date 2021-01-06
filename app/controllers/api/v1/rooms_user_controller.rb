module Api
  module V1
    class RoomsUserController < ApplicationController
      before_action :authorize_access_request!

      def create
        # 1.mailer

        # 2.Broadcast

      end
    end
  end
end