module ControllerMacros

  # def sign_in_as_a_valid_user
  #   # ASk factory bot to generate a valid user for us.
  #   @user ||= FactoryBot.create :user
  #   # We action the login request using the parameters before we begin.
  #   # The login requests will match these to the user we just created in the factory, and authenticate us.
  #   post user_session_path, user: {email: @user.email, password: @user.password}
  # end

  def login(user)
    post user_session_url, params: {
      user: {
        email: user.email, password: user.password
      }
    }
    follow_redirect!
  end

  # def login_user
  #   # Before each test, create and login the user
  #     @request.env['devise.mapping'] = Devise.mappings[:user]
  #     user = FactoryBot.create(:user)
  #     user.confirm! # Or set a confirmed_at inside the factory. Only necessary if  using the "confirmable" module
  #     sign_in user
  # end

  # an example of different user types
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryBot.create(:admin) # Using factory bot as an example
  #   end
  # end
end
