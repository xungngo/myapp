module Geolocation
  extend ActiveSupport::Concern

  def geoloc_lat_long(model_param)
    model_param[:latitude] = nil
    model_param[:longitude] = nil
    geoloc = JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{model_param[:address]}&key=AIzaSyAsCilLl4Pts-_BVVKJLoR_PCC7OmQsRcA"))

    if geoloc['status'] == 'OK' && geoloc['results'][0]['geometry']['location']['lat'].present?
      model_param[:latitude] = geoloc['results'][0]['geometry']['location']['lat']
      model_param[:longitude] = geoloc['results'][0]['geometry']['location']['lng']
      return true
    else
      return false
    end
  rescue
    return false
  end
end