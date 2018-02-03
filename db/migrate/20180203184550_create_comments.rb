class CreateComments < ActiveRecord::Migration[5.1]
  create_table :comments do |t|
    t.string :name
    t.integer :user_id
    t.integer :event_id
  end
end
end
