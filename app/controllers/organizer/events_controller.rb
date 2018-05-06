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
    geolocation
    @event = Event.new(event_params)
    if @event.save && Eventdate.create(params, @event.id)
      create_images
      flash[:success] = "The event was created successfully."
      redirect_to organizer_events_path
    elsif params[:eventdate].size.to_i == 1
      @event.errors.add(:base, "At least one event date is required.")
      render :action => :edit
    else
      render :action => :new
    end
  end

  def edit
    edit_update_instances
  end

  def update
    edit_update_instances
    geolocation
    if @event.update(event_params) && Eventdate.update(params, @event.id) # && verify_has_image(@event.id)
      flash[:success] = "The event was updated successfully."
      redirect_to organizer_events_path
    elsif params[:eventdate].size.to_i == 1
      @event.errors.add(:base, "At least one event date is required.")
      render :action => :edit
    elsif !verify_has_image(@event.id)
      @event.errors.add(:base, "At least one image is required.")
      render :action => :edit
    else
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
      if image['image_id'].present?
        Attachment.where(id: image['image_id'], event_id: params[:event_id]).update(sort: image['index'])
      else
        data_in = data.map {|d| d['image_id'] if d['image_id'].present?}.compact
        Attachment.where(image_file_name: image['image_name'], image_file_size: image['image_size'], event_id: params[:event_id]).where.not(id: data_in).update(sort: image['index'])
      end
    }
  end

  def get_images_json
    render json: images_to_json(Event.includes(:attachments).find(params[:id]).attachments.order(sort: :asc))
  end

  def status
    # binding.pry
    @no_wrapper = true
    @event = Event.find(params[:event_id])
    return "The status was updated!"
    #respond_to do |format|
      #format.html
      #format.js
    #end
  end

  def status_activate
    @no_wrapper = true
    @event = Event.find(params[:event_id])
    if @event.update(active: true)
      @status_change_message = "Successful Activation"
      flash[:success] = "The event status was updated successfully."
    else
      @status_change_message = "Unsuccessful Activation"   
      flash[:danger] = "The event status did not update successfully."
    end
    render :action => :status_change
  end

  def status_deactivate
    @no_wrapper = true
    @event = Event.find(params[:event_id])
    if @event.update(active: false)
      @status_change_message = "Successful Deactivation"
      flash[:success] = "The event status was updated successfully."
    else
      @status_change_message = "Unsuccessful Deactivation"   
      flash[:danger] = "The event status did not update successfully."
    end
    render :action => :status_change
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :requirement, :price, :contact, :address, :eventtype_id, :eventattendeetype_id, :latitude, :longitude, :images => [])
    .merge(uuid: SecureRandom.hex, active: true)
  end

    def geolocation
      params[:event][:latitude] = nil
      params[:event][:longitude] = nil
      geoloc = JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:event][:address]}&key=AIzaSyAsCilLl4Pts-_BVVKJLoR_PCC7OmQsRcA"))

      if geoloc['status'] == 'OK' && geoloc['results'][0]['geometry']['location']['lat'].present?
        params[:event][:latitude] = geoloc['results'][0]['geometry']['location']['lat']
        params[:event][:longitude] = geoloc['results'][0]['geometry']['location']['lng']
        return true
      else
        # params[:event][:address] = nil
        return false
      end
    rescue
      # params[:event][:address] = nil
      return false
    end

    def edit_update_instances
      @event = Event.includes(:eventtype, :eventattendeetype, :eventdates, :attachments).find(params[:id])
      @img_json = images_to_json(@event.attachments.order(sort: :asc))
    end

    def verify_has_image(eid)
      attachment = Attachment.find_by(event_id: eid)
      attachment.present? ? true : false
    end
end
