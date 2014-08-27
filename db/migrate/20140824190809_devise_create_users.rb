class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Rememberable
      t.datetime  :remember_created_at
      t.string    :provider,            null: false
      t.string    :uid,                 null: false
      t.string    :username,            null: false

      t.timestamps
    end
  end
end
