class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.integer :event_id
      t.attachment :image
      t.integer :sort
    end
  end
end
