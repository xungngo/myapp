class Admin::UsersController < ApplicationController
  include Geolocation
  before_action :authenticate_user
  #load_and_authorize_resource # cancancan

	def index
		@users = User.includes(:user_role_mappings, :roles).order(:last_name, :first_name, :middle_name)
	end

  def user_home
    @user = User.find(current_user.id)

    if current_user.present?
      @companies = Company.order(:code).where(:active => true, :id => UsersCompany.company_ids(current_user.id))
    else
      @companies = Company.all
    end
  end

	def user_profile
    @user = User.find(current_user.id)
  end

  def user_profile_update
    @user = User.find(current_user.id)
    if @user.update(firstname: params[:user][:firstname], middleinit: params[:user][:middleinit], lastname: params[:user][:lastname], address1: params[:user][:address1], address2: params[:user][:address2], city: params[:user][:city], state_id: params[:user][:state_id].to_i, zipcode: params[:user][:zipcode], profile_updated_at: Time.now)
      flash[:success] = "User profile was updated successfully."
      redirect_to user_profile_path
    else
      render :action => :user_profile
    end
  end

  def user_company
    # @company = Company.includes(:users_companies).find_by('users_companies.user_id' => current_user.id)
    # above will work with 'errors' hash. Below will work only using [0] otherwise 'errors' is undefined
    @company = Company.find(current_user.company_ids[0])
  end

  def user_company_update
    @company = Company.find(current_user.company_ids[0])
    geoloc_lat_long(params[:company])

    if @company.update(name: params[:company][:name], description: params[:company][:description], address: params[:company][:address], apt: params[:company][:apt], latitude: params[:company][:latitude], longitude: params[:company][:longitude])
      flash[:success] = "User company was updated successfully."
      redirect_to user_company_path
    else
      render :action => :user_company
    end
  end

  def user_preferences
    @user = User.find(current_user.id)
  end

  def user_preferences_update
    @user = User.find(current_user.id)
    if User.username_is_taken(params[:user][:username], current_user.id)
      flash[:danger] = "This username is taken."
      redirect_to user_preferences_path
    elsif User.email_is_taken(params[:user][:email], current_user.id)
      flash[:danger] = "This email is taken."
      redirect_to user_preferences_path
    elsif @user.update(username: params[:user][:username], email: params[:user][:email], timezone: params[:user][:timezone], preferences_updated_at: Time.now)
      flash[:success] = "User preferences were updated successfully."
      redirect_to user_preferences_path
    else
      render :action => :user_preferences
    end
  end

  def user_preferences_avatar_update
    @user = User.find(current_user.id)
    if params[:user].present?
      if @user.update(avatar_params)
        flash[:success] = "User avatar was added successfully."
        redirect_to user_preferences_path avtr:1
      else
        @user.errors.delete(:avatar)
        render :action => :user_preferences
      end
    else
      flash[:danger] = "Please upload an image as your avatar."
      redirect_to user_preferences_path avtr:1
    end
  end

  def user_preferences_avatar_delete
    @user = User.find(current_user.id)
    @user.avatar = nil
    @user.save
    if @user.save
      flash[:success] = "User avatar was deleted successfully."
      redirect_to user_preferences_path avtr:1
    else
      flash[:danger] = "User avatar was NOT deleted. Please try again later."
      redirect_to user_preferences_path avtr:1
    end
  end

  def user_security
    @user = User.find(current_user.id)
  end

  def user_security_update
    if password_current_is_blank(params) || password_digest_is_blank(params)
      flash[:danger] = "All fields are required!"
    elsif password_not_valid(params)
      flash[:danger] = "The new password format is not valid!"
    elsif password_not_confirmed(params)
      flash[:danger] = "The new password does not match the confirm password!"
    else
      if User.change_password(params, current_user)
        flash[:success] = "User password was updated successfully."
      else
        flash[:danger] = "The current password is not correct!"
      end
    end
    redirect_to user_security_path
	end

=begin
	def new
		@user = User.new

		role_list
	end

	def create
	  role_list

    @user = User.create(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name], :samaccountname => params[:user][:samaccountname], :active => params[:user][:active], :division_ids => params[:user][:division_ids], :role_ids => params[:user][:role_ids])

		if @user.save
			redirect_to admin_users_path
		else
			render :action => :new
		end
	end
=end

	def edit
		@user = User.find(params[:id])

    role_list
	end

	def update
	  role_list
    @user = User.find(params[:id])

    if (params[:user][:active] == "false") && (params[:id].to_i == current_user.id)
      @user.errors.add(:base, "You may not deactivate your own account.")
      render :action => :edit
    else
      if @user.update(:active => params[:user][:active], :role_ids => params[:user][:role_ids], :company_ids => params[:user][:company_ids])
        redirect_to admin_users_path
      else
        render :action => :edit
      end
    end
	end

  private

  def avatar_params
    params.require(:user).permit(:avatar).merge(preferences_updated_at: Time.now)
  end

	def role_list
	  @role_list = Role.all
=begin
    if current_user.sys_admin?
      @role_list = Role.all
    else
      @role_list = Role.all.where.not(unique_key: 'sys_admin')
    end
=end
	end
end
