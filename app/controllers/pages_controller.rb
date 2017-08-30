class PagesController < ApplicationController
  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def getmarkers
    sql = "SELECT name, address, latitude, longitude FROM markers WHERE name LIKE '%#{params[:input_keyword]}%' GROUP BY name, address, latitude, longitude HAVING (3959 * acos(cos(radians('#{params[:input_latitude]}')) * cos(radians(latitude)) * cos(radians(longitude) - radians('#{params[:input_longitude]}')) + sin( radians('#{params[:input_latitude]}') ) * sin(radians(latitude)))) < 10"
    @markers = ActiveRecord::Base.connection.execute(sql)
    #@markers = @markers.where("name LIKE (?)", "%#{params[:input_keyword]}%")
    #@markers = @markers.execute("HAVING distance < 5")
    render :json => @markers.as_json
  end
end