class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :listings, :verification

  	add_column :listings, :verification, :boolean, default: false
  end
end
