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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140125041052) do

  create_table "announcements", :force => true do |t|
    t.string   "content"
    t.string   "kind",       :null => false
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "announcements", ["kind"], :name => "index_announcements_on_kind"
  add_index "announcements", ["user_id"], :name => "index_announcements_on_user_id"

  create_table "announcements_users", :force => true do |t|
    t.integer "announcement_id"
    t.integer "user_id"
  end

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "batches", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "item_id"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "batches", ["item_id"], :name => "index_batches_on_item_id"
  add_index "batches", ["purchase_id"], :name => "index_batches_on_purchase_id"

  create_table "bonus_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bonuses", :force => true do |t|
    t.integer  "bonus_type_id"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "bonuses", ["bonus_type_id"], :name => "index_bonuses_on_bonus_type_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "client_categories", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_characteristics", :force => true do |t|
    t.integer  "client_category_id"
    t.text     "comment"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "client_characteristics", ["client_category_id"], :name => "index_client_characteristics_on_client_category_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "card_number"
    t.string   "full_phone_number"
    t.string   "surname"
    t.string   "patronymic"
    t.date     "birthday"
    t.string   "email"
    t.text     "admin_info"
    t.string   "contact_phone"
    t.integer  "category"
    t.integer  "client_characteristic_id"
  end

  add_index "clients", ["card_number"], :name => "index_clients_on_card_number"
  add_index "clients", ["category"], :name => "index_clients_on_category"
  add_index "clients", ["email"], :name => "index_clients_on_email"
  add_index "clients", ["full_phone_number"], :name => "index_clients_on_full_phone_number"
  add_index "clients", ["name"], :name => "index_clients_on_name"
  add_index "clients", ["patronymic"], :name => "index_clients_on_patronymic"
  add_index "clients", ["phone_number"], :name => "index_clients_on_phone_number"
  add_index "clients", ["surname"], :name => "index_clients_on_surname"

  create_table "comments", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.text     "content",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contractors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "device_tasks", :force => true do |t|
    t.integer  "device_id"
    t.integer  "task_id"
    t.boolean  "done",         :default => false
    t.text     "comment"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.decimal  "cost"
    t.datetime "done_at"
    t.text     "user_comment"
  end

  add_index "device_tasks", ["device_id"], :name => "index_device_tasks_on_device_id"
  add_index "device_tasks", ["done"], :name => "index_device_tasks_on_done"
  add_index "device_tasks", ["done_at"], :name => "index_device_tasks_on_done_at"
  add_index "device_tasks", ["task_id"], :name => "index_device_tasks_on_task_id"

  create_table "device_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "ancestry"
    t.integer  "qty_for_replacement", :default => 0
    t.integer  "qty_replaced",        :default => 0
    t.integer  "qty_shop"
    t.integer  "qty_store"
    t.integer  "qty_reserve"
    t.integer  "expected_during"
    t.integer  "code_1c"
  end

  add_index "device_types", ["ancestry"], :name => "index_device_types_on_ancestry"
  add_index "device_types", ["code_1c"], :name => "index_device_types_on_code_1c"
  add_index "device_types", ["name"], :name => "index_device_types_on_name"

  create_table "devices", :force => true do |t|
    t.integer  "device_type_id"
    t.string   "ticket_number"
    t.integer  "client_id"
    t.text     "comment"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "done_at"
    t.string   "serial_number"
    t.integer  "location_id"
    t.integer  "user_id"
    t.string   "imei"
    t.boolean  "replaced",        :default => false
    t.string   "security_code"
    t.string   "status"
    t.boolean  "notify_client",   :default => false
    t.boolean  "client_notified"
    t.datetime "return_at"
    t.integer  "item_id"
    t.string   "app_store_pass"
    t.text     "tech_notice"
  end

  add_index "devices", ["client_id"], :name => "index_devices_on_client_id"
  add_index "devices", ["device_type_id"], :name => "index_devices_on_device_type_id"
  add_index "devices", ["done_at"], :name => "index_devices_on_done_at"
  add_index "devices", ["imei"], :name => "index_devices_on_imei"
  add_index "devices", ["item_id"], :name => "index_devices_on_item_id"
  add_index "devices", ["location_id"], :name => "index_devices_on_location_id"
  add_index "devices", ["status"], :name => "index_devices_on_status"
  add_index "devices", ["ticket_number"], :name => "index_devices_on_ticket_number"
  add_index "devices", ["user_id"], :name => "index_devices_on_user_id"

  create_table "discounts", :force => true do |t|
    t.integer  "value"
    t.integer  "limit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discounts", ["limit"], :name => "index_discounts_on_limit"

  create_table "duty_days", :force => true do |t|
    t.integer  "user_id"
    t.date     "day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "kind"
  end

  add_index "duty_days", ["day"], :name => "index_duty_days_on_day"
  add_index "duty_days", ["kind"], :name => "index_duty_days_on_kind"
  add_index "duty_days", ["user_id"], :name => "index_duty_days_on_user_id"

  create_table "feature_types", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feature_types", ["kind"], :name => "index_feature_types_on_code"

  create_table "feature_types_product_categories", :force => true do |t|
    t.integer "product_category_id"
    t.integer "feature_type_id"
  end

  create_table "features", :force => true do |t|
    t.integer  "feature_type_id"
    t.integer  "item_id"
    t.string   "value"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "features", ["feature_type_id"], :name => "index_features_on_feature_type_id"
  add_index "features", ["item_id"], :name => "index_features_on_item_id"

  create_table "features_items", :force => true do |t|
    t.integer "feature_id"
    t.integer "item_id"
  end

  create_table "gift_certificates", :force => true do |t|
    t.string   "number"
    t.integer  "nominal"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "consumed"
  end

  add_index "gift_certificates", ["number"], :name => "index_gift_certificates_on_number"

  create_table "history_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "column_name"
    t.string   "column_type"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "old_value"
    t.text     "new_value"
  end

  add_index "history_records", ["column_name"], :name => "index_history_records_on_column_name"
  add_index "history_records", ["object_id", "object_type"], :name => "index_history_records_on_object_id_and_object_type"
  add_index "history_records", ["user_id"], :name => "index_history_records_on_user_id"

  create_table "infos", :force => true do |t|
    t.string   "title",                           :null => false
    t.text     "content",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "important",    :default => false
    t.integer  "recipient_id"
    t.boolean  "is_archived",  :default => false
  end

  add_index "infos", ["recipient_id"], :name => "index_infos_on_recipient_id"
  add_index "infos", ["title"], :name => "index_infos_on_title"

  create_table "installment_plans", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.string   "object"
    t.integer  "cost"
    t.date     "issued_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_closed",  :default => false
  end

  add_index "installment_plans", ["is_closed"], :name => "index_installment_plans_on_is_closed"
  add_index "installment_plans", ["user_id"], :name => "index_installment_plans_on_user_id"

  create_table "installments", :force => true do |t|
    t.integer  "installment_plan_id"
    t.integer  "value"
    t.date     "paid_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "installments", ["installment_plan_id"], :name => "index_installments_on_installment_plan_id"

  create_table "items", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "barcode_num"
  end

  add_index "items", ["product_id"], :name => "index_items_on_product_id"

  create_table "karma_groups", :force => true do |t|
    t.integer  "bonus_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "karma_groups", ["bonus_id"], :name => "index_karma_groups_on_bonus_id"

  create_table "karmas", :force => true do |t|
    t.boolean  "good"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "karma_group_id"
  end

  add_index "karmas", ["karma_group_id"], :name => "index_karmas_on_karma_group_id"
  add_index "karmas", ["user_id"], :name => "index_karmas_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "schedule"
    t.integer  "position",   :default => 0
  end

  add_index "locations", ["ancestry"], :name => "index_locations_on_ancestry"
  add_index "locations", ["name"], :name => "index_locations_on_name"
  add_index "locations", ["schedule"], :name => "index_locations_on_schedule"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "movement_acts", :force => true do |t|
    t.datetime "date"
    t.integer  "store_id"
    t.integer  "dst_store_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "movement_acts", ["dst_store_id"], :name => "index_movement_acts_on_dst_store_id"
  add_index "movement_acts", ["store_id"], :name => "index_movement_acts_on_store_id"
  add_index "movement_acts", ["user_id"], :name => "index_movement_acts_on_user_id"

  create_table "movement_items", :force => true do |t|
    t.integer  "movement_act_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "movement_items", ["item_id"], :name => "index_movement_items_on_item_id"
  add_index "movement_items", ["movement_act_id"], :name => "index_movement_items_on_movement_act_id"

  create_table "orders", :force => true do |t|
    t.string   "number"
    t.integer  "customer_id"
    t.string   "customer_type"
    t.string   "object_kind"
    t.string   "object"
    t.date     "desired_date"
    t.string   "status"
    t.text     "comment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.text     "user_comment"
  end

  add_index "orders", ["customer_id", "customer_type"], :name => "index_orders_on_customer_id_and_customer_type"
  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["object_kind"], :name => "index_orders_on_object_kind"
  add_index "orders", ["status"], :name => "index_orders_on_status"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "payment_types", :force => true do |t|
    t.string   "name"
    t.integer  "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "payment_types", ["kind"], :name => "index_payment_types_on_kind"

  create_table "payments", :force => true do |t|
    t.string   "kind"
    t.decimal  "value"
    t.integer  "sale_id"
    t.integer  "bank_id"
    t.integer  "gift_certificate_id"
    t.string   "device_name"
    t.string   "device_number"
    t.string   "client_info"
    t.string   "appraiser"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "payments", ["bank_id"], :name => "index_payments_on_bank_id"
  add_index "payments", ["gift_certificate_id"], :name => "index_payments_on_gift_certificate_id"
  add_index "payments", ["kind"], :name => "index_payments_on_kind"
  add_index "payments", ["sale_id"], :name => "index_payments_on_sale_id"

  create_table "price_types", :force => true do |t|
    t.string   "name"
    t.integer  "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "price_types", ["kind"], :name => "index_price_types_on_kind"

  create_table "price_types_stores", :force => true do |t|
    t.integer "price_type_id"
    t.integer "store_id"
  end

  add_index "price_types_stores", ["price_type_id"], :name => "index_price_types_stores_on_price_type_id"
  add_index "price_types_stores", ["store_id"], :name => "index_price_types_stores_on_store_id"

  create_table "prices", :force => true do |t|
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.boolean  "feature_accounting", :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "warranty_term"
    t.string   "kind"
    t.boolean  "request_price"
  end

  add_index "product_categories", ["kind"], :name => "index_product_categories_on_kind"

  create_table "product_groups", :force => true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.integer  "product_category_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "ancestry_depth",      :default => 0
  end

  add_index "product_groups", ["ancestry"], :name => "index_product_groups_on_ancestry"
  add_index "product_groups", ["product_category_id"], :name => "index_product_groups_on_product_category_id"

  create_table "product_prices", :force => true do |t|
    t.integer  "product_id"
    t.integer  "price_type_id"
    t.datetime "date"
    t.decimal  "value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "product_prices", ["price_type_id"], :name => "index_product_prices_on_price_type_id"
  add_index "product_prices", ["product_id"], :name => "index_product_prices_on_product_id"

  create_table "product_relations", :force => true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.integer  "relatable_id"
    t.string   "relatable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "product_relations", ["parent_type", "parent_id"], :name => "index_product_relations_on_parent_type_and_parent_id"
  add_index "product_relations", ["relatable_type", "relatable_id"], :name => "index_product_relations_on_relatable_type_and_relatable_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "product_group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "warranty_term"
    t.integer  "device_type_id"
  end

  add_index "products", ["code"], :name => "index_products_on_code"
  add_index "products", ["device_type_id"], :name => "index_products_on_device_type_id"
  add_index "products", ["product_group_id"], :name => "index_products_on_product_group_id"

  create_table "purchases", :force => true do |t|
    t.integer  "contractor_id"
    t.integer  "store_id"
    t.datetime "date"
    t.integer  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "purchases", ["contractor_id"], :name => "index_purchases_on_contractor_id"
  add_index "purchases", ["status"], :name => "index_purchases_on_status"
  add_index "purchases", ["store_id"], :name => "index_purchases_on_store_id"

  create_table "revaluation_acts", :force => true do |t|
    t.integer  "price_type_id"
    t.datetime "date"
    t.integer  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "revaluation_acts", ["price_type_id"], :name => "index_revaluation_acts_on_price_type_id"
  add_index "revaluation_acts", ["status"], :name => "index_revaluation_acts_on_status"

  create_table "revaluations", :force => true do |t|
    t.integer  "revaluation_act_id"
    t.integer  "product_id"
    t.decimal  "price"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "revaluations", ["product_id"], :name => "index_revaluations_on_product_id"
  add_index "revaluations", ["revaluation_act_id"], :name => "index_revaluations_on_revaluation_act_id"

  create_table "salaries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "issued_at"
    t.boolean  "is_prepayment"
  end

  add_index "salaries", ["is_prepayment"], :name => "index_salaries_on_is_prepayment"
  add_index "salaries", ["user_id"], :name => "index_salaries_on_user_id"

  create_table "sale_items", :force => true do |t|
    t.integer  "sale_id"
    t.integer  "item_id"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.decimal  "discount",                                 :default => 0.0
  end

  add_index "sale_items", ["item_id"], :name => "index_sale_items_on_item_id"
  add_index "sale_items", ["sale_id"], :name => "index_sale_items_on_sale_id"

  create_table "sales", :force => true do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "date"
    t.integer  "status"
    t.boolean  "is_return"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sales", ["client_id"], :name => "index_sales_on_client_id"
  add_index "sales", ["status"], :name => "index_sales_on_status"
  add_index "sales", ["store_id"], :name => "index_sales_on_store_id"
  add_index "sales", ["user_id"], :name => "index_sales_on_user_id"

  create_table "schedule_days", :force => true do |t|
    t.integer  "user_id"
    t.integer  "day"
    t.string   "hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schedule_days", ["day"], :name => "index_schedule_days_on_day"
  add_index "schedule_days", ["user_id"], :name => "index_schedule_days_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "presentation"
    t.text     "value"
    t.string   "value_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "settings", ["name"], :name => "index_settings_on_name"

  create_table "stolen_phones", :force => true do |t|
    t.string   "imei",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stolen_phones", ["imei"], :name => "index_stolen_phones_on_imei"

  create_table "store_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "store_id"
    t.integer  "quantity",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "store_items", ["item_id"], :name => "index_store_items_on_item_id"
  add_index "store_items", ["store_id"], :name => "index_store_items_on_store_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
  end

  add_index "stores", ["code"], :name => "index_stores_on_code"

  create_table "supplies", :force => true do |t|
    t.integer  "supply_report_id"
    t.integer  "supply_category_id"
    t.string   "name"
    t.integer  "quantity"
    t.decimal  "cost"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "supplies", ["supply_category_id"], :name => "index_supplies_on_supply_category_id"
  add_index "supplies", ["supply_report_id"], :name => "index_supplies_on_supply_report_id"

  create_table "supply_categories", :force => true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "supply_categories", ["ancestry"], :name => "index_supply_categories_on_ancestry"

  create_table "supply_reports", :force => true do |t|
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supply_requests", :force => true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.string   "object"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "supply_requests", ["status"], :name => "index_supply_requests_on_status"
  add_index "supply_requests", ["user_id"], :name => "index_supply_requests_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.decimal  "cost"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "priority",    :default => 0
    t.string   "role"
    t.integer  "location_id"
    t.integer  "product_id"
  end

  add_index "tasks", ["location_id"], :name => "index_tasks_on_location_id"
  add_index "tasks", ["name"], :name => "index_tasks_on_name"
  add_index "tasks", ["product_id"], :name => "index_tasks_on_product_id"
  add_index "tasks", ["role"], :name => "index_tasks_on_role"

  create_table "timesheet_days", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.string   "status"
    t.integer  "work_mins"
    t.time     "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "timesheet_days", ["date"], :name => "index_timesheet_days_on_date"
  add_index "timesheet_days", ["status"], :name => "index_timesheet_days_on_status"
  add_index "timesheet_days", ["user_id"], :name => "index_timesheet_days_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "role"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "location_id"
    t.string   "photo"
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.date     "birthday"
    t.date     "hiring_date"
    t.date     "salary_date"
    t.string   "prepayment"
    t.text     "wish"
    t.string   "card_number"
    t.string   "color"
    t.integer  "abilities_mask"
    t.boolean  "schedule"
    t.integer  "position"
    t.boolean  "is_fired"
    t.string   "job_title"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["card_number"], :name => "index_users_on_card_number"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["is_fired"], :name => "index_users_on_is_fired"
  add_index "users", ["job_title"], :name => "index_users_on_job_title"
  add_index "users", ["location_id"], :name => "index_users_on_location_id"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["patronymic"], :name => "index_users_on_patronymic"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["schedule"], :name => "index_users_on_schedule"
  add_index "users", ["surname"], :name => "index_users_on_surname"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "wiki_page_attachments", :force => true do |t|
    t.integer  "page_id",                           :null => false
    t.string   "wiki_page_attachment_file_name"
    t.string   "wiki_page_attachment_content_type"
    t.integer  "wiki_page_attachment_file_size"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "wiki_page_versions", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "updator_id"
    t.integer  "number"
    t.string   "comment"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "updated_at"
  end

  add_index "wiki_page_versions", ["page_id"], :name => "index_wiki_page_versions_on_page_id"
  add_index "wiki_page_versions", ["updator_id"], :name => "index_wiki_page_versions_on_updator_id"

  create_table "wiki_pages", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wiki_pages", ["creator_id"], :name => "index_wiki_pages_on_creator_id"
  add_index "wiki_pages", ["path"], :name => "index_wiki_pages_on_path", :unique => true

end
