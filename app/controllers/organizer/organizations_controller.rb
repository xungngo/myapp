class Organizer::OrganizationsController < ApplicationController
  before_action :authenticate_user
  #load_and_authorize_resource # cancancan

  def index
    @organizations = Organization.all.order(name: :asc)
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to admin_organizations_path
    else
      render action: :edit
    end
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to admin_organizations_path
    else
      render action: :edit
    end
  end

  def status
    @no_wrapper = true
    @organization = Organization.find(params[:organization_id])
  end

  def status_update
    @no_wrapper = true
    @organization = Organization.find(params[:organization_id])
    case params[:type]
    when "Default"
      Organization.find_user_id(params[:organization_id])
      update = @organization.update(default: true)
    when "Delete"
      update = @organization.destroy
    end

    if update
      @status_change_message = "#{params[:type]}d Successfully"
      flash[:success] = "The event status was updated successfully."
    else
      @status_change_message = "Error: Could Not #{params[:type]}"   
      flash[:danger] = "The event status did not update successfully."
    end
    render :action => :status_change
  end  

private

  def organization_params
    params.require(:organization).permit(:name, :address, :latitude, :longitude, :default)
  end
end
