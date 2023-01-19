class RenameEmailColumnToUsername < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :users, :email, :username
  end

  def self.down
    rename_column :users, :username, :email
  end
end
