class RegistrationsController < Devise::RegistrationsController


  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact_number,
                                 :avatar, :date_of_birth, :address,
                                 :password, :password_confirmation)
  end
end