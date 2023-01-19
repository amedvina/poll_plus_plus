class AddAuthorToPolls < ActiveRecord::Migration[7.0]
  def change
    add_column :polls, :author, :integer
  end
end
