class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table  :organizations do |t|
      t.string    :name, limit: 200
      t.string    :address, limit: 500
      t.string    :apt, limit: 100
      t.string    :contact, limit: 300
      t.decimal   :latitude, precision: 10, scale: 6, null: false
      t.decimal   :longitude, precision: 10, scale: 6, null: false
      t.boolean   :defaultorg, :null => false, :default => true
      t.timestamps null: true
    end
  end
end
