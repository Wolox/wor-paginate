# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_24_175354) do

  create_table "dummy_model_grand_sons", force: :cascade do |t|
    t.string "name"
    t.integer "something"
    t.integer "dummy_model_son_id"
    t.index ["dummy_model_son_id"], name: "index_dummy_model_grand_sons_on_dummy_model_son_id"
  end

  create_table "dummy_model_sons", force: :cascade do |t|
    t.string "name"
    t.integer "something"
    t.integer "dummy_model_id"
    t.index ["dummy_model_id"], name: "index_dummy_model_sons_on_dummy_model_id"
  end

  create_table "dummy_models", force: :cascade do |t|
    t.string "name"
    t.integer "something"
  end

  add_foreign_key "dummy_model_grand_sons", "dummy_model_sons"
  add_foreign_key "dummy_model_sons", "dummy_models"
end
