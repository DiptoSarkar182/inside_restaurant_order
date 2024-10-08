module ApplicationHelper
  def hide_elements_on_pages?
    pages_to_hide_elements = [
      { controller: 'sessions', action: 'new' },
      { controller: 'sessions', action: 'create' },
      { controller: 'registrations', action: 'new' },
      { controller: 'registrations', action: 'create' },
      { controller: 'passwords', action: 'new' },
      { controller: 'passwords', action: 'edit' },
      { controller: 'passwords', action: 'create' },
      { controller: 'passwords', action: 'update' }
    ]

    # Debugging: Print the current controller and action
    Rails.logger.debug "Current controller: #{params[:controller]}"
    Rails.logger.debug "Current action: #{params[:action]}"

    pages_to_hide_elements.any? do |page|
      params[:controller] == page[:controller] && params[:action] == page[:action]
    end
  end
end