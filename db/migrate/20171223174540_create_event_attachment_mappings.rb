class CreateEventAttachmentMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attachment_mappings do |t|
      t.integer :event_id
      t.integer :attachment_id

      t.timestamps null: true
    end
  end
end
