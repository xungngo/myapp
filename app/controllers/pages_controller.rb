class PagesController < ApplicationController
  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def getmarkers
    @markers = Marker.all
    render :json => @markers.as_json
  end
end