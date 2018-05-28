class AdminController < ApplicationController
	before_action :authenticate_user
  #load_and_authorize_resource #cancancan

	def index
	end

  def dashboard
    if current_user.admin?
      @companies = Company.order(:code).where(:active => true)
    else
      @companies = Company.order(:code).where(:active => true, :id => UsersCompany.company_ids(current_user.id))
    end
  end

end
