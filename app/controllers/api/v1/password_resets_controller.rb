module Api
  module V1
    class PasswordResetsController < ApplicationController
      before_action :set_user, only: [:edit, :update]
      KEYS = [:password, :password_confirmation].freeze

      # 1. forgot password
      def create
        user = User.find_by(email: params[:email])
        if user
          user.generate_password_token!
          UserMailer.reset_password(user).deliver_now
        end
        render json: :ok
      end

      # 2. mail link
      def edit
        render json: :ok
      end

      # 3. 変更
      def update
        @user.update!(password_params)
        @user.clear_password_token!
        JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced
        render json: :ok
      end

      private

        def password_params
          params.tap { |p| p.require(KEYS) }.permit(*KEYS) 
        end

        def set_user
          @user = User.find_by(reset_password_token: params[:token])
          # @user = User.find_by(email: params[:email])
          raise ResetPasswordError unless @user&.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.now
        end
    end
  end
end

