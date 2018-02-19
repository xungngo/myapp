class Attachment < ActiveRecord::Base
  has_many :event_attachment_mappings
  has_many :events, :through => :event_attachment_mappings

  # attachment with paperclip
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/, message: 'Attachment should be an image type such as: jpeg, gif, or png.'
  validates_attachment_size :attachment, :less_than => 500.kilobytes, message: 'Attachment file size should be less than 500Kb!'
end
