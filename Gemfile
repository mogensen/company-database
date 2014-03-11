source 'https://rubygems.org'
gem 'sinatra'

gem 'dm-is-versioned'

gem 'json'
gem 'data_mapper'

# When developing an app locally you can use SQLite which is a relational
# database stored in a file. It's easy to set up and just fine for most
# development situations.
group :development, :test do
	gem 'rspec'
	gem 'rack-test'
	gem 'dm-sqlite-adapter'
end

# Heroku uses Postgres however, so we tell the Gemfile to use Postgres
# in production instead of SQLite.
group :production do
	gem 'dm-postgres-adapter'
end
