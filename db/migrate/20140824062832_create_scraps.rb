class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps, id: false do |t|
      t.string  :http_method,         null: false, default: "GET"
      t.string  :endpoint,            null: false
      t.integer :status_code,         null: false, default: 200
      t.string  :content_type,        null: false, default: "application/json"
      t.text    :body,                null: false
      t.boolean :is_public,           null: false, default: true
      t.text    :description,         null: true
      t.string  :language,            null: false, default: "json"

      t.string  :character_encoding,  null: false, default: "UTF-8"

      t.references :user

      t.datetime :created_at
      t.datetime :updated_at
      t.string :uid, null: false
    end

    add_index :scraps, :uid, unique: true
  end
end
