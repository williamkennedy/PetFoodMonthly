require "sinatra"
require "stripe"

configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000
end

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
    erb :"index", layout: :"layouts/main"
end