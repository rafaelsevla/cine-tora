# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def current_user
    Current.user
  end

  helper_method :current_user

  # Adicionar método de autenticação para o Active Admin
  def authenticate_user!
    unless current_user
      redirect_to new_session_path, alert: "Faça login para continuar"
    end
  end
end
