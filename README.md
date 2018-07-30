# README

1. git clone https://github.com/mcclymont/hivetec-test
2. cd hivetech-test
3. bundle install
4. [edit config/database.yml to have valid PostgreSQL username and password, or set env vars]
5. bundle exec rails db:create db:migrate
6. foreman start [or run lines in Procfile manually]
