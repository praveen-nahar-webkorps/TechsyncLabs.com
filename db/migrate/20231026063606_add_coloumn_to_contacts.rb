class AddColoumnToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :first_name, :string
    add_column :contacts, :last_name, :string
    add_column :contacts, :phone, :integer
    add_column :contacts, :address, :string
  end
end
