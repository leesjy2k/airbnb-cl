class AddPaidToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :paid, :boolean, default: false, null: false
  end
end
