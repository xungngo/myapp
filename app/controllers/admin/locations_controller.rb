class Admin::LocationsController < ApplicationController

=begin
  before_action :authenticate_user!
  load_and_authorize_resource #cancancan

  def index
    @locations = Location.includes(:directorate, :region, :agency).all.order(:fconame)
  end

  def new
    @location = Location.new
    dropdown_lists

    render :edit
  end

  def edit
    @location = Location.find(params[:id])
    dropdown_lists
  end

  def create
    @location = Location.new(location_params)
    dropdown_lists

    if @location.save
      redirect_to admin_locations_path
    else
      render action: :edit
    end
  end

  def update
    @location = Location.find(params[:id])
    dropdown_lists

    if @location.update(location_params)
      redirect_to admin_locations_path
    else
      render action: :edit
    end
  end

private

  #needed if using cancancan
  def location_params
    params.require(:location).permit(:fcocode, :fconame, :agency_id, :directorate_id, :region_id, :activefile, :active)
  end

  def dropdown_lists
    @agencies = Agency.all.order(:name).where(:active => true)
    @directorates = Directorate.all.order(:name).where(:active => true)
    @regions = Region.all.order(:name).where(:active => true)
  end
=end
end
