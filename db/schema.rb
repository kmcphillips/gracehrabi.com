# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140604182107) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "authorized_emails", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorized_emails", ["email"], name: "index_authorized_emails_on_email", using: :btree

  create_table "blocks", force: true do |t|
    t.text     "body"
    t.string   "label"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "accepts_image",      default: false
    t.string   "image_fingerprint"
  end

  add_index "blocks", ["label"], name: "index_blocks_on_label", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.boolean  "disabled",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "contacts", ["disabled"], name: "index_contacts_on_disabled", using: :btree
  add_index "contacts", ["email"], name: "index_contacts_on_email", using: :btree
  add_index "contacts", ["token"], name: "index_contacts_on_token", using: :btree

  create_table "downloads", force: true do |t|
    t.string   "filename"
    t.string   "path"
    t.integer  "shopify_product_id"
    t.boolean  "allow_anonymous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "downloads", ["filename"], name: "index_downloads_on_filename", using: :btree
  add_index "downloads", ["shopify_product_id"], name: "index_downloads_on_shopify_product_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_fingerprint"
    t.boolean  "publicized",               default: true
    t.float    "price",                    default: 0.0
    t.datetime "published_to_facebook_at"
    t.string   "location"
  end

  add_index "events", ["publicized"], name: "index_events_on_publicized", using: :btree
  add_index "events", ["starts_at"], name: "index_events_on_starts_at", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "image"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["sort_order"], name: "index_galleries_on_sort_order", using: :btree

  create_table "images", force: true do |t|
    t.string   "label"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",            default: true
    t.integer  "sort_order"
    t.integer  "gallery_id"
  end

  add_index "images", ["active"], name: "index_images_on_active", using: :btree
  add_index "images", ["gallery_id"], name: "index_images_on_gallery_id", using: :btree
  add_index "images", ["sort_order"], name: "index_images_on_sort_order", using: :btree

  create_table "links", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
  end

  add_index "links", ["sort_order"], name: "index_links_on_sort_order", using: :btree

  create_table "lyrics", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lyrics", ["title"], name: "index_lyrics_on_title", using: :btree

  create_table "medias", force: true do |t|
    t.string   "label"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_fingerprint"
  end

  create_table "purchases", force: true do |t|
    t.integer  "download_id"
    t.integer  "webhook_id"
    t.string   "token"
    t.string   "email"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["download_id"], name: "index_purchases_on_download_id", using: :btree
  add_index "purchases", ["token"], name: "index_purchases_on_token", using: :btree
  add_index "purchases", ["webhook_id"], name: "index_purchases_on_webhook_id", using: :btree

  create_table "tracks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "sort_order"
    t.boolean  "active",           default: true
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["active"], name: "index_tracks_on_active", using: :btree
  add_index "tracks", ["sort_order"], name: "index_tracks_on_sort_order", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "webhooks", force: true do |t|
    t.text     "body"
    t.string   "status",     default: "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webhooks", ["created_at"], name: "index_webhooks_on_created_at", using: :btree
  add_index "webhooks", ["status"], name: "index_webhooks_on_status", using: :btree

end
