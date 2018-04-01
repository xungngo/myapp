module CustomJson
    extend ActiveSupport::Concern

    def images_to_json (query)
        attachments_list = []
        query.each do |attachment|
            attachment_list = { :name => attachment.image_file_name, :type => attachment.image_content_type,
                                :size => attachment.image_file_size, :file => attachment.image.url(:thumb),
                                :data => {:id => attachment.id, :url => attachment.image.url(:medium), :thumbnail => attachment.image.url(:thumb)} }
            attachments_list << attachment_list
        end
        attachments_list.to_json
    end
end