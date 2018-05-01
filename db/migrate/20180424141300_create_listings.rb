class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :property_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number
      t.string :country
      t.string :state
      t.string :city
      t.integer :zipcode
      t.string :address

      t.decimal :price, :precision => 8, :scale => 2
      t.string :description

      t.belongs_to :user
      t.timestamps
    end
  end
end