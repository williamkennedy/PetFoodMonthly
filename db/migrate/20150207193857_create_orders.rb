class CreateOrders < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.integer :customer_id
  		t.string :package_name
  		t.string :payment_status
  		t.string :shipping_status

  		t.timestamp
  	end
  end
end
