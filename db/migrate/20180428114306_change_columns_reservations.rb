class ChangeColumnsReservations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reservations, :verification

  	add_column :reservations, :verification, :boolean, default: false
  end
end
