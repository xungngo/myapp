class PagesController < ApplicationController
  def home
    session.delete(:authenticated_user) #also in application_controller.rb
    #if user_signed_in? && current_user.active
    if current_user && current_user.active
      return redirect_to admin_dashboard_path
    end
  end
end
