class AddAuthorIdToPolls < ActiveRecord::Migration[7.0]
  def change
    add_column :polls, :author_id, :integer, null: false
    add_index :polls, :author_id
  end
end
