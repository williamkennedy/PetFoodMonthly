class CreatePackages < ActiveRecord::Migration
  def change
  	create_table :packages do |t|
  		t.string :name
  		t.text	 :description
  		t.decimal :price, precision: 8, scale: 2
  		t.integer	:billing_frequency # 1 = Once monthly, 12 = Once yearly

  		t.timestamp
  	end
  end
end
