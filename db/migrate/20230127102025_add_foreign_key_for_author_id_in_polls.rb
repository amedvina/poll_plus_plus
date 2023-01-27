class AddForeignKeyForAuthorIdInPolls < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :polls, :users, column: :author_id
  end
end
