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

ActiveRecord::Schema.define(version: 20140706200249) do

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["name"], name: "index_districts_on_name"
  add_index "districts", ["region_id"], name: "index_districts_on_region_id"

  create_table "eqa_samples", force: true do |t|
    t.string   "specimen_id"
    t.string   "d_expected_result"
    t.string   "u_expected_result"
    t.string   "f_expected_result"
    t.integer  "eqa_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eqa_samples", ["eqa_test_id"], name: "index_eqa_samples_on_eqa_test_id"
  add_index "eqa_samples", ["specimen_id", "eqa_test_id"], name: "index_eqa_samples_on_specimen_id_and_eqa_test_id", unique: true

  create_table "eqa_tests", force: true do |t|
    t.string   "eqa_number"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eqa_tests", ["eqa_number"], name: "index_eqa_tests_on_eqa_number", unique: true

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.integer  "facility_type_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_no"
  end

  add_index "facilities", ["district_id"], name: "index_facilities_on_district_id"
  add_index "facilities", ["facility_no"], name: "index_facilities_on_facility_no", unique: true
  add_index "facilities", ["facility_type_id"], name: "index_facilities_on_facility_type_id"

  create_table "facility_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "final_result_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reagent_result_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.integer  "facility_id"
    t.integer  "eqa_test_id"
    t.date     "sample_receive_date"
    t.string   "done_by"
    t.string   "assay1_no"
    t.string   "assay2_no"
    t.string   "approved_by"
    t.date     "test_done_date"
    t.date     "assay1_expiry_date"
    t.date     "assay2_expiry_date"
    t.date     "result_dispatched_date"
    t.date     "result_received_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  add_index "results", ["eqa_test_id"], name: "index_results_on_eqa_test_id"
  add_index "results", ["facility_id", "eqa_test_id"], name: "index_results_on_facility_id_and_eqa_test_id", unique: true
  add_index "results", ["facility_id"], name: "index_results_on_facility_id"
  add_index "results", ["score"], name: "index_results_on_score"

  create_table "sample_results", force: true do |t|
    t.string   "specimen_id"
    t.string   "d_result"
    t.string   "u_result"
    t.string   "f_result"
    t.integer  "result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sample_results", ["d_result"], name: "index_sample_results_on_d_result"
  add_index "sample_results", ["f_result"], name: "index_sample_results_on_f_result"
  add_index "sample_results", ["result_id"], name: "index_sample_results_on_result_id"
  add_index "sample_results", ["u_result"], name: "index_sample_results_on_u_result"

  create_table "sent_samples", force: true do |t|
    t.string   "specimen_id"
    t.string   "d_expected_result"
    t.string   "u_expected_result"
    t.string   "f_expected_result"
    t.integer  "eqa_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id"
  end

  add_index "sent_samples", ["d_expected_result"], name: "index_sent_samples_on_d_expected_result"
  add_index "sent_samples", ["eqa_test_id"], name: "index_sent_samples_on_eqa_test_id"
  add_index "sent_samples", ["f_expected_result"], name: "index_sent_samples_on_f_expected_result"
  add_index "sent_samples", ["facility_id"], name: "index_sent_samples_on_facility_id"
  add_index "sent_samples", ["u_expected_result"], name: "index_sent_samples_on_u_expected_result"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
