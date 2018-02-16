class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table(:events) do |t|
      t.string :name, :limit => 100, null: false
      t.string :description, :limit => 2000, null: false
      t.string :requirement, :limit => 1000
      t.string :contact, :limit => 100
      t.string :address, :limit => 200, null: false
      t.string :price, :limit => 100
      t.integer :limit
      t.integer :eventtype_id, null: false
      t.integer :eventattendeetype_id, null: false
      t.string :tag, :limit => 100
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.boolean :active, null: false, default: true
      t.string :uuid, :limit => 100, null: false
      t.timestamps null: true
    end

    # add_index :events, :name, unique: true
  end
end
