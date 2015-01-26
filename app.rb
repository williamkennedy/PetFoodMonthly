require "sinatra"
require "stripe"

configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000
end

get '/' do
    erb :"index", layout: :"layouts/main"
end

# ---- Stripe Configuration --- #
set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

post '/charge' do
	# Amount in cents
	@amount = 500

	customer = Stripe::Customer.create(
		:email	=> 'customer@example.com',
		:card	=> params[:stripeToken]
		)

	charge = Stripe::Charge.create(
		:amount			=> @amount,
		:description	=> 'Sinatra Charge',
		:currency		=> 'usd',
		:customer		=> customer.id
		)

	erb :charge
end