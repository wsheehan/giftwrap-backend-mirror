ransom = School.create!(name: "Ransom Everglades", designation: ['Annual Fund: Wherever needed most',
	'Annual Fund: Financial Aid', 'Annual Fund: Fine Arts', 'Annual Fund: Technology',
	'Annual Fund: Athletics', 'Annual Fund: Faculty Development', 'Other'])

ransom.donors.create!(first_name: "Greg", last_name: "Pollard", email: "gpollard@ransomeverglades.org", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Ben", last_name: "Sheehan", email: "sheehan1102@gmail.com", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Will", last_name: "Sheehan", email: "willsheehan95@gmail.com", key: SecureRandom.urlsafe_base64(16))


School.create!(name: "Kimball Union", designation: ['Where KUA Needs it Most',
	'Access Fund for Financial Aid','Leadership Fund for Faculty Excellence',
	'Community Fund for Student Achievement','Coaches Fund for Athletics',
	'Encore Fund for Creative Arts','Senior Class Gift 2016','Other'])

FactoryGirl.create_list :client, 20

Client.all.each do |client|
	users = FactoryGirl.create_list :user, 4
	users.each { |u| client.users << u }
	donors = FactoryGirl.create_list :donor, 20
	donors.each { |d| client.donors << d }
	client.create_form
end

Subscription.create!(frequency: "monthly", interval: 1)
Subscription.create!(frequency: "quarterly", interval: 3)
Subscription.create!(frequency: "annually", interval: 12)

Donor.all.each do |x|
	rand  = rand(5..10)
	rand.times do |n|
		total = rand(10..100000)
		Gift.create!(total: total, donor_id: x.id)
	end
end

10.times do
	list = FactoryGirl.create :donor_list
	rand = rand(10..20)
	donors = Donor.all.sample(rand)
	donors.each {|x| list.donors << x }
end


User.all.each do |user|
	campaigns = FactoryGirl.create_list :campaign, 7, user_id: user.id
end

5.times do
	c = FactoryGirl.create :client
	20.times do
		d = FactoryGirl.create :donor
		c.donors << d
	end
end





