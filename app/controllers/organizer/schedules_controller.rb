class Organizer::SchedulesController < ApplicationController
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token, :only => [:create]
  #load_and_authorize_resource # cancancan

  def index
    #@schedules = Schedule.includes(:company_schedules).where('company_schedules.company_id' => current_user.company_ids.first).order(name: :asc)
  end

  def new
    @no_wrapper = true
    @schedule = Schedule.new
  end

  def edit
    #@schedule = Schedule.find(params[:id])
  end

  def create
    binding.pry
    #@schedule = Schedule.new(schedule_params)

    #if @schedule.create_company_schedule!(current_user.company_ids.first)
    #  flash[:success] = "The schedule was created successfully."
    #  redirect_to organizer_schedules_path
    #else
    #  render :action => :new
    #end
  end

  def update
    #@schedule = Schedule.find(params[:id])
    #@schedule.assign_attributes(schedule_params)

    #if @schedule.update_company_schedule!(current_user.company_ids.first)
    #  flash[:success] = "The schedule was updated successfully."
    #  redirect_to organizer_schedules_path
    #else
    #  render action: :edit
    #end
  end

  def status
    #@no_wrapper = true
    #@schedule = Schedule.find(params[:schedule_id])
  end

  def status_update
=begin
    @no_wrapper = true
    @schedule = Schedule.find(params[:schedule_id])
    case params[:type]
    when "Delete"
      if ok_to_delete
        update = @schedule.destroy
        Schedule.includes(:company_schedules).where("company_schedules.company_id" => current_user.company_ids.first).first.update(defaultorg: "true") if update && @schedule.defaultorg
      else
        flash[:danger] = "At least one schedule is required."
        update = false
      end
    end

    if update
      @status_change_message = "#{params[:type]}d Successfully"
      flash[:success] = "The schedule status was updated successfully."
    else
      @status_change_message = "Could Not #{params[:type]}"
      flash[:danger] ||= "The schedule status did not update successfully."
    end
    render :action => :status_change
=end
  end

private

  def schedule_params
    params.require(:schedule).permit(:name)
  end

  def ok_to_delete
    org_count = Schedule.includes(:company_schedules).where("company_schedules.company_id" => current_user.company_ids.first).count
    if org_count == 1
      return false
    else
      return true
    end
  end
end
