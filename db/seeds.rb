# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Create admin
# User.create(email: "sean.lee.sijian@gmail.com",
# 						password: "123456",
# 						name: "Sean Lee",
# 						avatar: File.open(Rails.root + 'app/assets/images/lsj.jpg'), 
# 						location: "Johor Bahru",
# 						state: "Johor",
# 						country: "Malaysia",
# 						description: "Yes I am happy with my place."
# 						)
# puts "==============================================================================="
# puts "Admin user created!"
# puts "==============================================================================="

# # Creates dummy users

# puts "\n==============================================================================="
rand(5..15).times do
	user = User.create(email: Faker::Internet.email,
										 password: "123456",
										 name: Faker::Name.name,
										 avatar: Faker::Avatar.image,
										 location: Faker::Address.city,
										 country: Faker::Address.country,
										 description: Faker::Lorem.paragraph(2), 
										 role: rand(0..1)
										 )
	puts "User \"#{user.name}\" created! Email: #{user.email}"
end
puts "==============================================================================="
puts "Total number of users created: #{User.all.count}\n\n"

# Creates random number of listings

# puts "\n==============================================================================="
User.all.each do |user|
	total = 0
	rand(1..3).times do
		listing = user.listings.create(title: Faker::Hipster.sentence(3, false),
										 description: Faker::Hipster.paragraph(3..10),
										 home_type: ["Apartment", "Condominium", "Townhouse", "Villa", "Studio", "Loft", "Dorm", "Castle", "Tent", "Boat"].sample,
										 location: Faker::Address.street_address,
										 guest: rand(1..6),
										 bedroom: rand(1..5),
										 price: rand(40..500),
										 breakfast: [true, false].sample
								)
		listing.images = [File.open(Rails.root + "app/assets/images/listings/#{rand(1..12)}.jpg")]
		listing.save!
		total += 1
	end
	puts "==============================================================================="
	puts "#{total} listing(s) created for #{user.name}!"
	puts "==============================================================================="
end
puts "Total number of listings created: #{Listing.all.count}"
puts "===============================================================================\n\n"

puts "\n=============================== (\"\\( ^ o ^ )/\") ==============================="
puts "              Success! You can login using the credentials below:"
puts "                 email: sean.lee.sijian@gmail.com        password: 123456"
puts "==============================================================================="