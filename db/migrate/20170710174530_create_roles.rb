class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name # Used for display only; change if needed
      t.string :unique_key # do not change
      t.integer :display_rank, :null => false, :default => 5
    end
  end
end
