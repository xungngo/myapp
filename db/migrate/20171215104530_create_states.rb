class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name, :null => false
      t.string :abbr, :null => false
    end
  end
end
