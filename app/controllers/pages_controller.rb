class PagesController < ApplicationController
  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def getmarkers
    @markers = Marker.where("name LIKE (?)", "%#{params[:input_keyword]}%")
    render :json => @markers.as_json
  end
end