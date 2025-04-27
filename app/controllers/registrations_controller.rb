class RegistrationsController < Devise::RegistrationsController
    # Override the default create method
    def create
      user = User.new(user_params)
      if user.save
       
        token = generate_jwt_token(user)  
        
        render json: { user: user, message: "Successfully created user", token: token }, status: :created
      else
        render json: { message: "Failed to create user", errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private 
  
    def user_params
      
      params.require(:user).permit(:email, :password, :name)
    end
  
    
    def generate_jwt_token(user)
      JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise[:jwt_secret_key])
    end
  end
  