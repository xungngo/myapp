class CreateEventdatesEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :eventdates_events, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :eventdate, index: true
    end
  end
end
