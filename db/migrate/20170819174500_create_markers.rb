class CreateMarkers < ActiveRecord::Migration[5.0]
  def change
    create_table(:markers) do |t|
      t.string :name, limit: 100, null: false
      t.string :address, limit: 100, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.boolean :active, default: true
      t.timestamps null: true
    end

    #add_index :markers, :name
  end
end