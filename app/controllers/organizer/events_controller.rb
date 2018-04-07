class Organizer::EventsController < ApplicationController
  before_action :authenticate_user
  protect_from_forgery with: :null_session, only: [:create_attachments]
  include CustomJson
  #load_and_authorize_resource # cancancan

  def index
    @events = Event.includes(:eventtype).all.order(created_at: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    if params[:event].present?
      @event = Event.new(event_params)
      if @event.save && Eventdate.create(params, @event.id)
        create_images
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
    @event = Event.includes(:eventtype, :eventattendeetype, :eventdates, :attachments).find(params[:id])
    @img_json = images_to_json(@event.attachments.order(sort: :asc))
  end

  def update
    if params[:event].present?
      @event = Event.find(params[:id])
      if @event.update(event_params) && Eventdate.update(params, @event.id)
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

  def create_images
    params[:event_id] ||= @event.id
    if params[:images]
      params[:images].each_with_index() { |image, index|
        Attachment.create(event_id: params[:event_id], image: image, sort: index)
      }
    end
  end

  def update_image
    new_img = Attachment.where(event_id: params[:event_id])
    new_img.create(image: params[:images][0], sort: new_img.size)
  end

  def delete_image
    Attachment.where(event_id: params[:event_id]).delete(params[:image_id])
  end

  def sort_image
    data = JSON.parse(params[:_list])
    data.each { |image|
      #binding.pry
      if image['image_id'].present?
        Attachment.where(id: image['image_id'], event_id: params[:event_id]).update(sort: image['index'])
      else
        Attachment.where(event_id: params[:event_id], sort: nil).update(sort: image['index'])
      end
    }
  end

  private
  
    def event_params
      params.require(:event).permit(:name, :description, :requirement, :price, :contact, :address, :eventtype_id, :eventattendeetype_id, :images => [])
      .merge(latitude: 16.1234, longitude: 35.4456, uuid: SecureRandom.hex, active: true)
    end

end
