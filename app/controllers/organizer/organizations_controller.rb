class Organizer::OrganizationsController < ApplicationController
  before_action :authenticate_user
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
    # binding.pry
    if @organization.create_user_organization!(current_user.id)
      #@organization.save
      #@organization.users_organizations.create(user_id: current_user.id, organization_id: Organization.last.id)
      flash[:success] = "The organization was created successfully."
      redirect_to organizer_organizations_path
    else
      render :action => :new
    end
  end

  def update
    geolocation
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
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
      # params[:organization][:address] = nil
      return false
    end
  rescue
    # params[:organization][:address] = nil
    return false
  end  
end
