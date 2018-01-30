class AddColumnCommentsToEvents < ActiveRecord::Migration[5.1]
  def change
add_column :events, :comments, :text
end
end
