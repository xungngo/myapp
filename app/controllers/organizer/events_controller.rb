class Organizer::EventsController < ApplicationController
  before_action :authenticate_user
  #load_and_authorize_resource # cancancan

  def index
    @events = Event.includes(:eventtype).all.order(:name)
  end

  def new
    @event = Event.new
  end

  def create
    if params[:event].present?
      @event = Event.new(event_params)
      if @event.save && Eventdate.create(params, @event.id)
        flash[:success] = "The event was created successfully."
        redirect_to organizer_events_path
      else
        render :action => :new
      end
    else
      #flash[:danger] = "Please fill in all required form fields."
      render :action => :new
    end
  end

  def edit
    @event = Event.includes(:eventtype, :eventattendeetype, :eventdates).find(params[:id])
  end

  def update
    #binding.pry
    if params[:event].present?
      @event = Event.find(params[:id])
      if @event.update_attributes(event_params) && Eventdate.update(params, @event.id)
        flash[:success] = "The event was updated successfully."
        redirect_to organizer_events_path
      else
        #@event.errors.add(:base, "Error error error.")
        render :action => :edit
      end
    else
      #flash[:danger] = "Please fill in all required form fields."
      render :action => :edit
    end
  end

  private
  
    def event_params
      params.require(:event).permit(:name, :description, :requirement, :price, :contact, :address, :eventtype_id, :eventattendeetype_id).merge(latitude: 16.1234, longitude: 35.4456, uuid: SecureRandom.hex, active: true)
    end

end
