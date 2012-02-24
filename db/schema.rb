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

ActiveRecord::Schema.define(:version => 20120221004448) do

  create_table "articles", :force => true do |t|
    t.integer  "student_id",                :null => false
    t.string   "title",                     :null => false
    t.string   "message"
    t.text     "body",                      :null => false
    t.text     "freezebody"
    t.integer  "state",      :default => 0, :null => false
    t.date     "submitted"
    t.date     "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["student_id"], :name => "index_articles_on_student_id"

  create_table "comments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "article_id"
    t.string   "body",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["student_id", "article_id"], :name => "index_comments_on_student_id_and_article_id"

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "student_id", :null => false
    t.integer  "article_id", :null => false
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["article_id"], :name => "index_ratings_on_article_id"

  create_table "services", :force => true do |t|
    t.integer  "student_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "email",                                 :default => "",   :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.datetime "locked_at"
    t.string   "fullname"
    t.text     "shortbio"
    t.string   "weburl"
    t.integer  "lesson_id",                             :default => 1,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "haslocalpw",                            :default => true, :null => false
  end

  add_index "students", ["confirmation_token"], :name => "index_students_on_confirmation_token", :unique => true
  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["fullname"], :name => "index_students_on_fullname"
  add_index "students", ["lesson_id"], :name => "index_students_on_lesson_id"
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true

end
