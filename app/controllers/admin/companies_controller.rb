class Admin::CompaniesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource #cancancan

  def index
    @companies = Company.includes(:user).all.order(:name)
  end

  def new
    @company = Company.new

    render :edit
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to admin_companies_path
    else
      render action: :edit
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to admin_companies_path
    else
      render action: :edit
    end
  end

private

  def company_params
    params.require(:company).permit(:name, :description, :address, :address2, :user_id, :active)
  end
end
