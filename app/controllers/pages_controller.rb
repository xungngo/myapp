class PagesController < ApplicationController
  def home
    if current_user && current_user.active
      return redirect_to admin_dashboard_path
    end
  end
end
