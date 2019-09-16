class ApplicationController < ActionController::Base

  layout :layout

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || tambos_path
  end

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : 'application'
  end
end
