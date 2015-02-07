class Customer < ActiveRecord::Base
	validates :email_address, :first_name, :last_name, :shipping_address, presence: true
	validates :email_address, uniqueness: true, format: {
		with: &r{/@/./} #possibly implement Devise at a later date.
	}
end