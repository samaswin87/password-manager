# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_16_034659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_dynamic_attributes", id: :serial, force: :cascade do |t|
    t.integer "customizable_id", null: false
    t.string "customizable_type", limit: 50
    t.string "name"
    t.string "display_name", null: false
    t.integer "datatype"
    t.text "value"
    t.boolean "required", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customizable_id"], name: "index_active_dynamic_attributes_on_customizable_id"
    t.index ["customizable_type"], name: "index_active_dynamic_attributes_on_customizable_type"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "house_name"
    t.integer "number"
    t.string "street"
    t.string "additional_details"
    t.string "zipcode"
    t.string "linkable_type"
    t.bigint "linkable_id"
    t.bigint "city_id"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["linkable_type", "linkable_id"], name: "index_addresses_on_linkable_type_and_linkable_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "field_mappings", force: :cascade do |t|
    t.json "fields"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "file_imports", force: :cascade do |t|
    t.string "state"
    t.string "data_file_name"
    t.string "data_content_type"
    t.integer "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "completed_at"
    t.string "source_type"
    t.bigint "source_id"
    t.text "error_messages"
    t.integer "total_count", default: 0
    t.integer "parsed_count", default: 0
    t.integer "failed_count", default: 0
    t.integer "success_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_id"
    t.index ["source_type", "source_id"], name: "index_file_imports_on_source_type_and_source_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.string "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_field_attributes", force: :cascade do |t|
    t.json "attributes"
    t.bigint "file_import_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_import_id"], name: "index_import_field_attributes_on_file_import_id"
  end

  create_table "import_fields", force: :cascade do |t|
    t.bigint "file_import_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_import_id"], name: "index_import_fields_on_file_import_id"
  end

  create_table "password_attachments", force: :cascade do |t|
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.bigint "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.bigint "password_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["password_id"], name: "index_password_attachments_on_password_id"
  end

  create_table "passwords", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "username"
    t.string "text_password"
    t.string "key"
    t.text "ssh_private_key"
    t.text "details"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.text "ssh_public_key"
    t.string "ssh_finger_print"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "password_changed_at"
    t.datetime "password_copied_at"
    t.datetime "password_viwed_at"
    t.index ["user_id"], name: "index_passwords_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.string "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.integer "invited_by_type"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.bigint "gender_id"
    t.bigint "user_type_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["gender_id"], name: "index_users_on_gender_id"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", unique: true
    t.index ["invited_by_type"], name: "index_users_on_invited_by_type", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "states"
  add_foreign_key "cities", "states"
  add_foreign_key "import_field_attributes", "file_imports"
  add_foreign_key "import_fields", "file_imports"
  add_foreign_key "password_attachments", "passwords"
  add_foreign_key "passwords", "users"
  add_foreign_key "users", "genders"
  add_foreign_key "users", "user_types"
end
