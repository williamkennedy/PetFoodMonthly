require "sinatra"

configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000
end

    get '/' do
        erb :"index", layout: :"layouts/main"
    end