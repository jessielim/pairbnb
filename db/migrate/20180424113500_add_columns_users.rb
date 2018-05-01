class AddColumnsUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|

      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :gender
      t.date :birthday

    end

  end
end
