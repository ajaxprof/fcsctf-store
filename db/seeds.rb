require 'net/http'
require 'uri'
require 'digest/md5'

resp = Net::HTTP.get(URI('https://fcsctf.ru/api/v1/scoreboard'))
resp = JSON.parse(resp).with_indifferent_access
total_pts = resp[:data].inject(0) { |acc,cur| acc += cur[:score].to_i ; acc }

items = [
  {
    title: 'Карта Coffee Rooms',
    description: 'Подарочная карта в Coffee Rooms на 1500 рублей',
    price: (total_pts * 0.10000).round,
    quantity: 1,
    image_url: 'https://pp.userapi.com/c622422/v622422622/1ac1e/HSNToM1zXjQ.jpg?ava=1',
    max_allowed: nil
  },
  {
    title: 'Кот в мешке',
    description: 'Случайный подарок из секретного спец списка , коты не пострадали',
    price: (total_pts * 0.06000).round,
    quantity: 3,
    image_url: 'https://i.ibb.co/BfFjhfW/cat.png',
    max_allowed: nil
  },
  {
    title: 'Наушники Xiaomi Mi Earphone Basic',
    description: 'Наушники Xiaomi Mi Earphone Basic',
    price: (total_pts * 0.05333).round,
    quantity: 1,
    image_url: 'https://images-na.ssl-images-amazon.com/images/I/71mQ9oKDMLL._SX466_.jpg',
    max_allowed: nil
  },
  {
    title: 'Флешка с принтом Игоря Борисовича',
    description: 'Экслюзивная флешка с принтом Игоря Борисовича Ларионова',
    price: (total_pts * 0.07500).round,
    quantity: 5,
    image_url: 'https://pp.userapi.com/c849028/v849028419/16fa2b/fnFBQoBPAzA.jpg',
    max_allowed: 2
  },
  {
    title: 'Кружка Jurassic Park',
    description: 'Экслюзивная кружка с принтом Юрия Сергеевича Ракицкого \'Jurassic Park\' и история в комплекте',
    price: (total_pts * 0.10000).round,
    quantity: 2,
    image_url: 'https://pp.userapi.com/c847018/v847018929/1e3680/xcrhskkuXU8.jpg',
    max_allowed: 1
  },
  {
    title: '10 байт',
    description: 'Пак из 10 байт',
    price: (total_pts * 0.03000).round,
    quantity: 20,
    image_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBstXcTyWF1qGG6-i4PAA2BFSEBcmiRrihynN56sJOOLjj8lCk',
    max_allowed: 6
  }
]

Transaction.all.each(&:destroy)
User.all.each(&:destroy)
Item.all.each(&:destroy)
items.each do |item|
  Item.create(item)
end

User.create(team_name: 'admin', password: '1d57d92b9b20084ca610b7624c1ffc19', balance: 9999)

salt = '8b512e52b5894b0a1749ac8290ca89d7'

resp[:data].each do |team|
  password = Digest::MD5.hexdigest("#{salt}#{team[:name]}#{salt}")
  puts "#{team[:name]} => #{password}"
  User.create({ team_name: team[:name], balance: team[:score], password: password })
end