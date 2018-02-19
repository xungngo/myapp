class PagesController < ApplicationController

  #def allowed_params
  #  params.require(:page).permit(:firstname, :lastname, :email, :password_digest, :password_confirmation)
  #end

  def home
    #if current_user && current_user.active
     # return redirect_to admin_dashboard_path
    #end
  end

  def signin
    if params[:logoff]
      session[:user_id] = nil
      @logoff = "You were successfully logged off."
    elsif params[:validate] && User.validate(params[:validate]).present?
      @validated = "You were successfully validated. Please sign in below."
    elsif params[:validate] && !User.validate(params[:validate]).present?
      @validated = "We can not validate your email. Please copy and paste the url from your email."
    end
  end

  def signin_result
    if email_is_blank(params) || password_digest_is_blank(params)
      return_message = [{"message":"The email and password are required!"}]
    elsif User.authenticate(params).present?
      if User.not_validated?(params)
        return_message = [{"message":"Please validate your email before your first sign in."}]
      else
        session[:user_id] = User.authenticate(params).id
        return_message = [{"message":"success", "goto":"user"}]
      end
    else
      return_message = [{"message":"Incorrect email or password. Please try again."}]
    end
    render :json => return_message.as_json
  end

  def register

  end

  def register_result
    if firstname_is_blank(params) || lastname_is_blank(params) || email_is_blank(params) || password_digest_is_blank(params)
      return_message = [{"message":"All fields are required!"}]
    elsif password_not_valid(params)
      return_message = [{"message":"The password format is not valid!"}]
    elsif password_not_confirmed(params)
      return_message = [{"message":"The password does not match the confirm password!"}]
    else
      regis_user = User.register(params)
      if regis_user.id.present?
        return_message = [{"message":"success", "goto":"signin?registered=1"}]
        ApplicationMailer.register_email(regis_user).deliver # send the email notification
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
    end
    render :json => return_message.as_json
  end

  def forgot  
  end

  def aboutus    
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
end