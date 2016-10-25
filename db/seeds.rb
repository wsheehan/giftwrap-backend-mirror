ransom = Client.create!(name: "Ransom Everglades")
#designation: ['Annual Fund: Wherever needed most','Annual Fund: Financial Aid', 'Annual Fund: Fine Arts', 'Annual Fund: Technology','Annual Fund: Athletics', 'Annual Fund: Faculty Development', 'Other']

Client.create!(name: "Kimball Union")
#designation: ['Where KUA Needs it Most','Access Fund for Financial Aid','Leadership Fund for Faculty Excellence','Community Fund for Student Achievement','Coaches Fund for Athletics','Encore Fund for Creative Arts','Senior Class Gift 2016','Other']

ransom.donors.create!(first_name: "Greg", last_name: "Pollard", email: "gpollard@ransomeverglades.org", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Ben", last_name: "Sheehan", email: "sheehan1102@gmail.com", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Will", last_name: "Sheehan", email: "willsheehan95@gmail.com", key: SecureRandom.urlsafe_base64(16))

affiliations = ["Parent", "Student", "Alumni"]

Client.all.each do |client|
	users = FactoryGirl.create_list :user, 4
	users.each { |u| client.users << u }
	40.times do
		a = affiliations.sample
		Donor.create!(first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			email: Faker::Internet.email,
			key: SecureRandom.urlsafe_base64(16),
			affiliation: a,
			class_year: (a == "Alumni" ? rand(1960..2015) : nil),
			)
	end
	Donor.all.each { |d| client.donors << d }
	client.create_form
	client.create_metric
end

Subscription.create!(frequency: "monthly", interval: 1)
Subscription.create!(frequency: "quarterly", interval: 3)
Subscription.create!(frequency: "annually", interval: 12)

Donor.all.each do |x|
	r  = rand(5..10)
	r.times do |n|
		total = rand(10..100000)
		Gift.create!(total: total, donor_id: x.id)
	end
end

10.times do
	list = FactoryGirl.create :donor_list
	donors = Donor.all.sample(rand(10..20))
	donors.each {|x| list.donors << x }
end

User.all.each do |user|
	campaigns = FactoryGirl.create_list :campaign, 7, user_id: user.id
end





