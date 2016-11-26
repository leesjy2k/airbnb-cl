class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :location, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :description, :string
  end
end
