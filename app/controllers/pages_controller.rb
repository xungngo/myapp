class PagesController < ApplicationController
  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def getmarkers
    haversine = "(3959 * acos(cos(radians('#{params[:input_latitude]}')) * cos(radians(latitude)) * cos(radians(longitude) - radians('#{params[:input_longitude]}')) + sin( radians('#{params[:input_latitude]}') ) * sin(radians(latitude))))"
    sql = "SELECT name, address, latitude, longitude,
          #{haversine} as distant
    FROM markers WHERE name LIKE '%#{params[:input_keyword]}%' 
    GROUP BY name, address, latitude, longitude 
    HAVING #{haversine} < 10
    ORDER BY distant ASC"
    @markers = ActiveRecord::Base.connection.execute(sql)
    render :json => @markers.as_json
  end
end