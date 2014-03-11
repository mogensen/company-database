# Setup DataMapper with a database URL.
# On Heroku, ENV['DATABASE_URL'] will be set, when working locally this line
# will fall back to using SQLite in the current directory.
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

require_relative 'company'
# require_relative 'director'
# require_relative 'owner'

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!

