class ApplicationController < ActionController::API
    before_action :authenticate_user!

    def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        decoded_token = decode_jwt(token)
        if decoded_token
          @current_user = User.find(decoded_token["user_id"])
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
      
      def decode_jwt(token)
        JWT.decode(token, Rails.application.credentials.devise[:jwt_secret_key])[0] rescue nil
      end
      
end
