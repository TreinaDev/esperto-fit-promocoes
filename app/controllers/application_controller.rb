class ApplicationController < ActionController::Base
  def authorize_admin
    redirect_to root_path, notice: 'Você não tem permissão para essa ação' unless current_user.admin?
  end
end
