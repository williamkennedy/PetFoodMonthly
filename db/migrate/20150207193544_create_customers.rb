class CreateCustomers < ActiveRecord::Migration
  def change
  	create_table :customers do |t|
  		t.string :email_address
  		t.string :first_name
  		t.string :last_name
  		t.text :shipping_address

  		t.timestamp
  	end
  end
end
