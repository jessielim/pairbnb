class AddReservations < ActiveRecord::Migration[5.0]
  def change
  	create_table :reservations do |t|
  		t.belongs_to :user
  		t.belongs_to :listing
  		t.integer :guest_number
  		t.date :start_date
  		t.date :end_date
  		t.boolean :verification
  		t.timestamps null: false
  	end
  end
end
