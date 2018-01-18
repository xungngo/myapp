class CreateEventattendees < ActiveRecord::Migration[5.0]
  def change
    create_table :eventattendees do |t|
      t.string :name, :limit => 100, null: false
      t.boolean :active, null: false, default: false
      t.timestamps null: true
    end
  end
end
