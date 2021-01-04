module Api
  module V1
    class EntriesController < ApplicationController
      before_action :authorize_access_request!
      def create
      end
    end
  end
end