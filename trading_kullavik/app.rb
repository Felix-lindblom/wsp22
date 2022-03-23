require "sinatra"
require "slim"
require "sqlite3"
require "bcrypt"

get ("/") do
    slim (:register)
end

post ("user/new") do
    username = params[:username]
    password = params[:password]
    password_conf = params[:password_conf]
    # inte klar här men följer videon

    if password == password_conf

    else
        "password är inte samma i fälten"
    end
end