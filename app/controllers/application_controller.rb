class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: :devise_controller?

  protected
  def after_sign_in_path_for(resource)
    if resource.is_admin?
      admin_dashboards_path
    else
      super
    end
  end
end
