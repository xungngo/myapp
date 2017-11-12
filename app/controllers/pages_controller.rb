class PagesController < ApplicationController

  #def allowed_params
  #  params.require(:page).permit(:firstname, :lastname, :email, :password_digest, :password_confirmation)
  #end

  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def login
    if params[:logoff]
      session[:user_id] = nil
      @logoff = "You were successfully logged off."
    end
  end

  def login_result
    if email_is_blank(params) || password_is_blank(params)
      return_message = [{"message":"The email and password are required!"}]
    elsif User.authenticate(params).present?
      session[:user_id] = User.authenticate(params).id
      return_message = [{"message":"success", "goto":"user"}]
    else
      return_message = [{"message":"This user is not in the system!"}]
    end
    render :json => return_message.as_json
  end

  def register

  end

  def register_result
    if firstname_is_blank(params) || lastname_is_blank(params) || email_is_blank(params) || password_is_blank(params)
      return_message = [{"message":"All fields are required!"}]
    elsif password_not_confirmed(params)
      return_message = [{"message":"The password does not confirm!"}]
    else
      regis_user = User.register(params)
      if regis_user.id.present?
        return_message = [{"message":"success", "goto":"login?registered=1"}]
      elsif regis_user.errors.messages[:firstname].present?
        return_message = [{"message":regis_user.errors.messages[:firstname]}]
      elsif regis_user.errors.messages[:lastname].present?
        return_message = [{"message":regis_user.errors.messages[:lastname]}]
      elsif regis_user.errors.messages[:email].present?
        return_message = [{"message":regis_user.errors.messages[:email]}]
      elsif regis_user.errors.messages[:password_digest].present?
        return_message = [{"message":regis_user.errors.messages[:password_digest]}]
      else
        return_message = [{"message":"System Error: please refresh the page and try again."}]
      end
      #binding.pry
    end
    render :json => return_message.as_json
  end

  def forgot
  
  end

  def getmarkers
    if params[:type] == 'organizer'
    haversine = "(3959 * acos(cos(radians('#{params[:input_latitude]}')) * cos(radians(latitude)) * cos(radians(longitude) - radians('#{params[:input_longitude]}')) + sin( radians('#{params[:input_latitude]}') ) * sin(radians(latitude))))"
    sql = "SELECT name, address, latitude, longitude, 'organizer' as type,
          #{haversine} as distant
    FROM markers WHERE name LIKE '%#{params[:input_keyword]}%' 
    GROUP BY name, address, latitude, longitude 
    HAVING #{haversine} < 1
    ORDER BY distant ASC"
    else
      haversine = "(3959 * acos(cos(radians('#{params[:input_latitude]}')) * cos(radians(latitude)) * cos(radians(longitude) - radians('#{params[:input_longitude]}')) + sin( radians('#{params[:input_latitude]}') ) * sin(radians(latitude))))"
      sql = "SELECT name, address, latitude, longitude, 'seeker' as type,
            #{haversine} as distant
      FROM markers WHERE name LIKE '%#{params[:input_keyword]}%' 
      GROUP BY name, address, latitude, longitude 
      HAVING #{haversine} < 10
      ORDER BY distant ASC"
    end
    @markers = ActiveRecord::Base.connection.execute(sql)
    render :json => @markers.as_json
  end

  private

  def email_is_blank(p)
    p[:email].blank? ? true : false
  end
  
  def password_is_blank(p)
    p[:password_digest].blank? ? true : false
  end

  def firstname_is_blank(p)
    p[:firstname].blank? ? true : false
  end
  
  def lastname_is_blank(p)
    p[:lastname].blank? ? true : false
  end
  
  def password_not_confirmed(p)
    p[:password_digest] == p[:password_confirmation] ? false : true
  end
end