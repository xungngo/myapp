class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table  :companies do |t|
      t.string    :name, limit: 100
      t.string    :description, limit: 200
      t.string    :address, limit: 200
      t.string    :apt, limit: 100
      t.decimal   :latitude, precision: 10, scale: 6, null: false
      t.decimal   :longitude, precision: 10, scale: 6, null: false
      t.boolean   :active, :null => false, :default => true
      t.timestamps null: true
    end
  end
end
