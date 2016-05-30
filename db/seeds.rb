
School.create!(name: "Kimball Union")

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
		Donor.create!(first_name: first_name, last_name: last_name, email: email, school_id: x.id, key: SecureRandom.urlsafe_base64(16))
	end
	x.create_form()
end

Donor.all.each do |x|
	rand  = rand(5..10)
	rand.times do |n|
		total = rand(10..100000)
		Gift.create!(total: total, school_id: x.school_id, donor_id: x.id)
	end
end

10.times do |x|
	title = Faker::Company.buzzword
	list = DonorList.create(title: title )
	rand = rand(10..20)
	donors = Donor.all.sample(rand)
	donors.each {|x| list.donors << x }
end

User.all.each do |x|
	7.times do |n|
		title = Faker::Company.buzzword
		Campaign.create!(title: title, user_id: x.id)
	end
end





