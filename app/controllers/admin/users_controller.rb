class Admin::UsersController < ApplicationController
	before_action :authenticate_user
  #load_and_authorize_resource # cancancan

  #def user_params
  #  params.require(:user).permit(:samaccountname)
  #end

	def index
		@users = User.includes(:user_role_mappings, :roles).order(:last_name, :first_name, :middle_name)
	end

	def user_home
    if current_user.present?
      @locations = Location.order(:code).where(:active => true, :id => UserLocationMapping.location_ids(current_user.id))
    else
      @locations = Location.all
    end
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
      if @user.update(:active => params[:user][:active], :role_ids => params[:user][:role_ids], :location_ids => params[:user][:location_ids])
        redirect_to admin_users_path
      else
        render :action => :edit
      end
    end
	end

  private

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
