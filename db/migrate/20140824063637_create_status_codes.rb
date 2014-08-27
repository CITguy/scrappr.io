class CreateStatusCodes < ActiveRecord::Migration
  def change
    create_table :status_codes do |t|
      t.integer :number,   null: false
      t.string  :desc,     null: false
      t.boolean :standard, null: false, default: false
      t.string  :rfc,      null: true
    end
  end
end
