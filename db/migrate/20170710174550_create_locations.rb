class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table  :locations do |t|
      t.string    :code, :limit => 10
      t.string    :name, :limit => 100
      t.boolean   :active, :null => false, :default => true
      t.timestamps null: true
    end
  end
end
