serhii = User.where(email: Faker::Internet.email('Serhii'), password: '11111111').create!
ivan = User.where(email: Faker::Internet.email('Ivan'), password: '11111111').create!

# 2.times do 
# 	event = serhii.created_events.create!(
# 		purpose: [Faker::Hacker.adjective, Faker::Hacker.noun].join(' ').titleize,
# 		place: Faker::Address.city,
# 		time: Faker::Time.forward(23, :morning)
# 		)
# 	event.comments.create!(body: Faker::Hacker.say_something_smart, user: ivan)
# end
