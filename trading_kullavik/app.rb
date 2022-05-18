require "sinatra"
require "slim"
require "sqlite3"
require "bcrypt"

enable :sessions

get ("/") do
    slim (:homepage)
end

get ("/register") do 
    slim (:register)
end

get ("/login") do
    slim (:login)
end

post ("/inlog") do
    username = params[:username]
    password = params[:password]
    db = SQLite3::Database.new("db/centralhub.db")
    db.results_as_hash = true
    result = db.execute("SELECT * FROM users WHERE usertag = ?",username).first
    pwdigest = result["pwdigest"]
    id = result["id"]
    if BCrypt::Password.new(pwdigest) == password
        session[:id] = id
        redirect('/scout')
    else
        "Fel lösenord"
    end
end

get ("/scout") do
    if session[:id] != nil
        slim(:scoutpage)
    else
        redirect('/register')
    end
end

post ("/users/new") do
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