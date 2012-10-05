class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.string :company
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
