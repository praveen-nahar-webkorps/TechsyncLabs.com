class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :phone1
      t.integer :phone2
      t.string :location
      t.string :message

      t.timestamps
    end
  end
end
