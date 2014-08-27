class CreatePiles < ActiveRecord::Migration
  def change
    create_table :piles do |t|
      t.string  :name,        null: false
      t.string  :slug,        null: false
      t.text    :description, null: true
      t.boolean :protected,   null: false, default: false

      t.references :user

      t.timestamps
    end
  end
end
