class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_job_colors

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def set_job_colors
    @color_by_status = {
      "completed" => "lightgreen",
      "created" => "lightgray",
      "submitted" => "LightSteelBlue",
      "failed" => "Salmon", "running" => "Moccasin",
      "unknown" => "white",
      "pending" => "LightSteelBlue"
    }
  end

  # Macht die Methode auch in Views nutzbar (optional, siehe Schritt 3)
  helper_method :current_user_admin?

  def current_user_admin?
    Current.user&.admin?
  end

  private

  def require_admin
    unless current_user_admin?
      redirect_to root_path, alert: "Zugriff verweigert: Administrator-Rechte erforderlich."
    end
  end
end
