class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :date
      t.integer :volunteers_needed
      t.string :description
    end
  end
end
