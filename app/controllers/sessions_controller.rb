class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:destroy]

  def destroy
    super
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "Signed out successfully."
    new_user_session_path
  end
end