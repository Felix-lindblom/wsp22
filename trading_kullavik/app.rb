require "sinatra"
require "slim"
require "sqlite3"
require "bcrypt"

get ("/") do
    slim (:homepage)
end

get ("/register") do 
    slim (:register)
end



post ("/user/new") do
    username = params[:username]
    password = params[:password]
    password_conf = params[:password_conf]
    # inte klar här men följer videon

    if password == password_conf
        password_digest = BCrypt::Password.create(password)
        db = SQLite3::Database.new("db/centralhub.db")
        db.execute("INSERT INTO users (usertag,pwdigest) VALUES (?,?)",username,password_digest)
        redirect("/")
        # funkar inte, kan vara usertag
    else
        "password är inte samma i fälten"
    end
end
# Hittar inte "/user/new"
get ("/login") do

end