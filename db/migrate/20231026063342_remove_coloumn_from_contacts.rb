class RemoveColoumnFromContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :name, :string
    remove_column :contacts, :phone1, :integer
    remove_column :contacts, :phone2, :integer
    remove_column :contacts, :location, :string
    remove_column :contacts, :message, :string
  end
end
