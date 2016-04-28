
20.times do |n|
	name = Faker::Company.name
	School.create!(name: name)
end

School.all.each do |x|
	4.times do |n|
		first_name = Faker::Name.first_name
		last_name = Faker::Name.last_name
		email = Faker::Internet.email
		User.create!(first_name: first_name, last_name: last_name, email: email, school_id: x.id)
	end
	20.times do |n|
		first_name = Faker::Name.first_name
		last_name = Faker::Name.last_name
		email = Faker::Internet.email
		Donor.create!(first_name: first_name, last_name: last_name, email: email, school_id: x.id)
	end
end

Donor.all.each do |x|
	rand  = rand(50..100)
	rand.times do |n|
		total = rand(10..100000)
		Gift.create!(total: total, school_id: x.school_id, donor_id: x.id)
	end
end

User.all.each do |x|
	7.times do |n|
		title = Faker::Company.buzzword
		Campaign.create!(title: title, user_id: x.id)
	end
end

