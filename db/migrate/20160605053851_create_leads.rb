class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :street_address
      t.string :city
      t.string :st
      t.string :zip
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
