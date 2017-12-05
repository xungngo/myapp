class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table(:users) do |t|
      t.string :email, :limit => 100, null: false, default: ""
      t.string :username, :limit => 100
      t.string :password_digest, :limit => 100
      t.string :firstname, :limit => 100
      t.string :middleinit, :limit => 100
      t.string :lastname, :limit => 100
      t.string :address, :limit => 200
      t.boolean :active, null: false, default: false
      t.string :uuid, :limit => 100, null: false
      t.datetime :validated_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :last_sign_in_at
      t.timestamps null: true
    end

    #add_index :users, :email,                unique: true
  end
end
