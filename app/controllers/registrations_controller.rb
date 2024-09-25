class RegistrationsController < Devise::RegistrationsController
  # Skip authentication for the registration actions
  skip_before_action :authenticate_user!, only: [:new, :create]

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation, :nationality)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation, :nationality)
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    # Set the flash message
    flash[:notice] = "A confirmation link has been sent to your email address."
    # Redirect to the login page
    new_user_session_path
  end
end