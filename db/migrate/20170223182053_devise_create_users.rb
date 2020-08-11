class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      # recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      # lockable
      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at

      # invitable
      t.string   :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer  :invitation_limit
      t.integer  :invited_by_id
      t.integer  :invited_by_type

      # defaults
      t.string     :first_name
      t.string     :last_name
      t.string     :phone
      t.references :gender, index: true, foreign_key: true
      t.references :user_type, index: true, foreign_key: true
      t.attachment :avatar

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :invitation_token,     unique: true
    add_index :users, :invited_by_id,        unique: true
    add_index :users, :invited_by_type,      unique: true
  end
end
