class AttachmentsController < ApplicationController
  protect_from_forgery with: :null_session
  #def allowed_params
  #  params.require(:attachment).permit(:images)
  #end

  def create
    @event_attachment = Event.find(params[:id])
    if params[:images]
      params[:images].each { |image|
        @event_attachment.attachments.create(image: image)
      }
    end
  end
end