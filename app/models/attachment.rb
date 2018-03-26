class Attachment < ActiveRecord::Base
  #has_many :event_attachment_mappings
  #has_many :events, :through => :event_attachment_mappings
  belongs_to :event
  
  # attachment with paperclip
  # imagemajick is tricky to install, read https://gist.github.com/rodleviton/74e22e952bd6e7e5bee1
  # use this cmd from above link: sudo apt-get install imagemagick libmagickcore-dev libmagickwand-dev libmagic-dev
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/, message: 'Attachment should be an image type such as: jpeg, gif, or png.'
  validates_attachment_size :image, :less_than => 4.megabytes, message: 'Attachment file size should be less than 5Mb!'
end
