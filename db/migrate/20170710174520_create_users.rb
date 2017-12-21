class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table(:users) do |t|
      t.string :email, :limit => 100, null: false, default: ""
      t.string :email_temp, :limit => 100, null: true
      t.datetime :email_validated_at
      t.string :username, :limit => 100
      t.string :password_digest, :limit => 100
      t.string :firstname, :limit => 100
      t.string :middleinit, :limit => 100
      t.string :lastname, :limit => 100
      t.string :address1, :limit => 100
      t.string :address2, :limit => 100
      t.string :city, :limit => 100
      t.integer :state_id
      t.string :zipcode, :limit => 5
      t.boolean :active, null: false, default: false
      t.string :uuid, :limit => 100, null: false
      t.datetime :validated_at
      t.string :timezone
      t.datetime :profile_updated_at
      t.datetime :preferences_updated_at
      t.datetime :security_updated_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :last_sign_in_at
      t.timestamps null: true
    end

    #add_index :users, :email,                unique: true
  end
end
