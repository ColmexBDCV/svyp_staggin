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

ActiveRecord::Schema.define(version: 2020_02_26_224848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.text "usuario"
    t.text "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docs_consulta", force: :cascade do |t|
    t.text "titulo"
    t.text "indice"
    t.string "documento_file_name"
    t.string "documento_content_type"
    t.integer "documento_file_size"
    t.datetime "documento_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imagens", force: :cascade do |t|
    t.string "imagen_file_name"
    t.string "imagen_content_type"
    t.integer "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.text "sesion"
    t.integer "indice"
    t.text "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personas", force: :cascade do |t|
    t.text "nombre"
    t.text "semblanza"
    t.string "foto_file_name"
    t.string "foto_content_type"
    t.integer "foto_file_size"
    t.datetime "foto_updated_at"
    t.text "twitter"
    t.text "fb"
    t.integer "indice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publicacions", force: :cascade do |t|
    t.text "titulo"
    t.string "portada_file_name"
    t.string "portada_content_type"
    t.integer "portada_file_size"
    t.datetime "portada_updated_at"
    t.text "autor"
    t.text "edicion"
    t.text "descripcion"
    t.text "liga_vid"
    t.integer "indice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "fecha"
    t.string "documento_file_name"
    t.string "documento_content_type"
    t.integer "documento_file_size"
    t.datetime "documento_updated_at"
  end

  create_table "sesions", force: :cascade do |t|
    t.text "titulo"
    t.text "descripcion"
    t.text "liga_vid"
    t.text "pubs"
    t.date "fecha_i"
    t.date "fecha_f"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
  end

  create_table "sliders", force: :cascade do |t|
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.text "liga"
    t.integer "indice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vids", force: :cascade do |t|
    t.text "liga"
    t.integer "indice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
