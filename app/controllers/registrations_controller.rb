class RegistrationsController < Devise::RegistrationsController
  # Skip authentication for the registration actions
  skip_before_action :authenticate_user!, only: [:new, :create, :destroy]

  def destroy
    Rails.logger.debug "Destroy action called"
    resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation, :nationality, :country_code)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation, :nationality, :current_password, :country_code)
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    # Set the flash message
    flash[:notice] = "A confirmation link has been sent to your email address."
    # Redirect to the login page
    new_user_session_path
  end

  def after_sign_out_path_for(resource_or_scope)
    # Set the flash message
    flash[:notice] = "Your account has been successfully deleted."
    # Redirect to the login page
    new_user_session_path
  end
end