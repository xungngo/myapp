class Organizer::OrganizationsController < ApplicationController
  include Geolocation
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token, :only => [:status_update]
  #load_and_authorize_resource # cancancan

  def index
    @organizations = Organization.includes(:company_organizations).where('company_organizations.company_id' => current_user.company_ids.first).order(name: :asc)
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    geoloc_lat_long(params[:organization])
    @organization = Organization.new(organization_params)

    if @organization.create_company_organization!(current_user.company_ids.first)
      flash[:success] = "The organization was created successfully."
      redirect_to organizer_organizations_path
    else
      render :action => :new
    end
  end

  def update
    geoloc_lat_long(params[:organization])
    @organization = Organization.find(params[:id])
    @organization.assign_attributes(organization_params)

    if @organization.update_company_organization!(current_user.company_ids.first)
      flash[:success] = "The organization was updated successfully."
      redirect_to organizer_organizations_path
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
    when "Delete"
      if ok_to_delete
        update = @organization.destroy
        Organization.includes(:company_organizations).where("company_organizations.company_id" => current_user.company_ids.first).first.update(defaultorg: "true") if update && @organization.defaultorg
      else
        flash[:danger] = "At least one organization is required."
        update = false
      end
    end

    if update
      @status_change_message = "#{params[:type]}d Successfully"
      flash[:success] = "The organization status was updated successfully."
    else
      @status_change_message = "Could Not #{params[:type]}"
      flash[:danger] ||= "The organization status did not update successfully."
    end
    render :action => :status_change
  end

private

  def organization_params
    params.require(:organization).permit(:name, :address, :contact, :latitude, :longitude, :defaultorg)
  end

  def ok_to_delete
    org_count = Organization.includes(:company_organizations).where("company_organizations.company_id" => current_user.company_ids.first).count
    if org_count == 1
      return false
    else
      return true
    end
  end
end
