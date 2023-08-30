class ApplicationController < ActionController::Base
  
  private

  def user_not_authorized
    flash[:alert] = I18n.t('flash.unauthorized')
    redirect_to(request.referrer || root_path)
  end
end
