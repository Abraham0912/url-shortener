class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.string :ip_adress
      t.string :browser
      t.string :os
      t.datetime :created_at
      t.references :link, null: false, foreign_key: true
    end
  end
end
