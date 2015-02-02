require "sinatra"
require "active_record"
require "stripe"

configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000
end

class Article < ActiveRecord::Base
end

get '/' do
    erb :"index", layout: :"layouts/main"
    Article.establish_connection(
    	:adapter => "sqlite3",
    	:database => "hw.db"
    )
    Article.first.title
end

# ---- Stripe Configuration --- #
set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

#token = params[:stripeToken]

post '/charge' do
	# Amount in cents
	@amount = 500

	customer = Stripe::Customer.create(
		:email	=> 'customer@example.com',
		:card	=> params[:stripeToken],
		:plan 	=> 'gold'
	)

	charge = Stripe::Charge.create(
		:amount			=> @amount,
		:description	=> 'Sinatra Charge',
    :currency		=> 'eur',
		:customer		=> customer.id
	)

	plan = Stripe::Plan.create(
	:amount		=> '2000',
	:interval	=> 'month',
	:name		=> 'Amazing Gold Plan',
	:currency	=> 'usd',
	:index		=> 'gold'
	)

	erb :charge
end

error Stripe::CardError do
	env['sinatra.error'].message
end

#__END__
#
#@@ layout
#  <!DOCTYPE html>
#  <html>
#  <head></head>
#  <body>
#  	<&= yield %>
#  </body>
#  </html>
#
#@@ index
#  <form action="/charge" method="post" class="payment">
#  	<article>
#  		<label class="amount">
#  			<span>Amount: $5.00</span>
#  		</label>
#  	</article>
#
#  	<script src="https://checkout.stripe.com/checkout.js" class="stripe-button" data-key="<%= settings.publishable_key %>"></script>
#  </form>
#
#@@ charge
#  <h2>Thanks, you paid <strong>$5.00</strong>!</h2>  