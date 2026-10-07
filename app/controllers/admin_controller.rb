class AdminController < ApplicationController
  # 1. Enforce that a user must be logged in (Provided by Rails 8 generator)
  before_action :require_authentication

  # 2. Enforce that the logged-in user must be an administrator
  before_action :require_admin

  private

  def require_admin
    # Current.user is globally accessible via the Rails 8 native auth concern
    unless Current.user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
