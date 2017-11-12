class UserController < ApplicationController
	before_action :authenticate_user
  #load_and_authorize_resource #cancancan

	def index
    if current_user.present?
      @locations = Location.order(:code).where(:active => true, :id => UserLocationMapping.location_ids(current_user.id))
    else
      @locations = Location.all
    end
  end
end
