# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "games", :force => true do |t|
    t.text     "talon"
    t.text     "tapis"
    t.integer  "courante"
    t.integer  "etendu"
    t.datetime "start"
    t.datetime "last_set"
    t.integer  "nb_set"
    t.integer  "nb_bad_set"
    t.integer  "nb_point"
    t.integer  "nb_last_point"
    t.float    "time_last_set"
    t.integer  "game_over"
    t.integer  "nb_set_possible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.datetime "last_set"
    t.integer  "nb_set"
    t.integer  "nb_bad_set"
    t.integer  "nb_point"
    t.integer  "nb_last_point"
    t.float    "time_last_set"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
