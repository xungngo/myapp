class AdminController < ApplicationController
	before_action :authenticate_user
  #load_and_authorize_resource #cancancan

	def index
	end

  def dashboard
    if current_user.admin?
      @locations = Location.order(:code).where(:active => true)
    else
      @locations = Location.order(:code).where(:active => true, :id => UserLocationMapping.location_ids(current_user.id))
    end
  end

end
