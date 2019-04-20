FCSCTF Store is the real-time store developed for FCSCTF event held in Faculty of Computer Science in Omsk State University.

It requires:
ruby version  >= 2.5.1
rails version >= 5.2
postgreSQL
redis-server

It can be easily deployed using a set of commands:
- docker-compose up -d --build
- docker-compose run web rake db:seed

Configuration:
Items for sale, users, price policies can be set in db/seeds.rb

It uses redis + actioncable for real-time updates and holds 5 concurrent connections per active user page
