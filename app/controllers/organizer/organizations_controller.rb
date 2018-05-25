class Organizer::OrganizationsController < ApplicationController
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token, :only => [:status_update]
  #load_and_authorize_resource # cancancan

  def index
    @organizations = Organization.includes(:users_organizations).where('users_organizations.user_id' => current_user.id).order(name: :asc)
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    geolocation
    @organization = Organization.new(organization_params)

    if @organization.create_user_organization!(current_user.id)
      flash[:success] = "The organization was created successfully."
      redirect_to organizer_organizations_path
    else
      render :action => :new
    end
  end

  def update
    geolocation
    @organization = Organization.find(params[:id])
    @organization.assign_attributes(organization_params)

    if @organization.update_user_organization!(current_user.id)
      flash[:success] = "The organization was updated successfully."
      redirect_to organizer_organizations_path
    else
      render action: :edit
    end
  end
=begin
  def update
    geolocation
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to organizer_organizations_path
    else
      render action: :edit
    end
  end
=end
  def status
    @no_wrapper = true
    @organization = Organization.find(params[:organization_id])
  end

  def status_update
    @no_wrapper = true
    @organization = Organization.find(params[:organization_id])
    case params[:type]
    when "Delete"
      update = @organization.destroy
      Organization.includes(:users_organizations).where("users_organizations.user_id" => current_user.id).first.update(defaultorg: "true") if update && @organization.defaultorg
    end

    if update
      @status_change_message = "#{params[:type]}d Successfully"
      flash[:success] = "The organization status was updated successfully."
    else
      @status_change_message = "Error: Could Not #{params[:type]}"
      flash[:danger] = "The organization status did not update successfully."
    end
    render :action => :status_change
  end

private

  def organization_params
    params.require(:organization).permit(:name, :address, :contact, :latitude, :longitude, :defaultorg)
  end

  def geolocation
    params[:organization][:latitude] = nil
    params[:organization][:longitude] = nil
    geoloc = JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:organization][:address]}&key=AIzaSyAsCilLl4Pts-_BVVKJLoR_PCC7OmQsRcA"))

    if geoloc['status'] == 'OK' && geoloc['results'][0]['geometry']['location']['lat'].present?
      params[:organization][:latitude] = geoloc['results'][0]['geometry']['location']['lat']
      params[:organization][:longitude] = geoloc['results'][0]['geometry']['location']['lng']
      return true
    else
      return false
    end
  rescue
    return false
  end
end
