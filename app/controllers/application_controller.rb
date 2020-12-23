class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from JWTSessions::Errors::ClaimsVerification, with: :forbidden

  private

    def current_user
      # payload(Ex) =>
      # {
      #  "exp"=>1608688240,
      #  "user_id"=>38,
      #  "aud"=>["user"],
      #  "uid"=>"e1b9bd13-4869-40c3-a05b-2a7c53320a25",
      #  "ruid"=>"6aea67ce-0aed-4c25-9ebf-dd776c8a0063"
      # }
      @current_user ||= User.find(payload['user_id'])
    end

    def not_authorized
      render json: { error: "Not Authorized" }, status: :unauthorized
    end

    def response_success(class_name, action_name)
      render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
    end

    def response_bad_request
      render status: 400, json: { status: 400, message: 'Bad Request' }
    end

    def response_unauthorized
      render status: 401, json: { status: 401, message: 'Unauthorized' }
    end

    def response_not_found(class_name = 'page')
      render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
    end

    def response_conflict(class_name)
      render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
    end

    def response_internal_server_error
      render status: 500, json: { status: 500, message: 'Internal Server Error' }
    end

    def forbidden
      render json: { error: 'Forbidden' }, status: :forbidden
    end
end
