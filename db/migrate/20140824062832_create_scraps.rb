class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.string  :http_method,         null: false, default: "GET"
      t.string  :endpoint,            null: false
      t.integer :status_code,         null: false, default: 200
      t.string  :content_type,        null: false, default: "application/json"
      t.text    :body,                null: false
      t.boolean :private,             null: false, default: false

      t.string  :character_encoding,  null: false, default: "UTF-8"

      t.references :pile

      t.timestamps
    end
  end
end
