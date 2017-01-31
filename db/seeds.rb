require 'factory_girl_rails'
# Production Seed:

# For Admin App
User.create! email: 'willsheehan95@gmail.com', password: "Giftwrap1", password_confirmation: "Giftwrap1", admin: true
User.create! email: 'sheehan1102@gmail.com', password: "Maple1648", password_confirmation: "Maple1648", admin: true

ransom = Client.create!(name: "Ransom Everglades")
#designation: ['Annual Fund: Wherever needed most','Annual Fund: Financial Aid', 'Annual Fund: Fine Arts', 'Annual Fund: Technology','Annual Fund: Athletics', 'Annual Fund: Faculty Development', 'Other']

Client.create!(name: "Kimball Union")
#designation: ['Where KUA Needs it Most','Access Fund for Financial Aid','Leadership Fund for Faculty Excellence','Community Fund for Student Achievement','Coaches Fund for Athletics','Encore Fund for Creative Arts','Senior Class Gift 2016','Other']

ransom.donors.create!(first_name: "Greg", last_name: "Pollard", email: "gpollard@ransomeverglades.org", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Ben", last_name: "Sheehan", email: "sheehan1102@gmail.com", key: SecureRandom.urlsafe_base64(16))
ransom.donors.create!(first_name: "Will", last_name: "Sheehan", email: "willsheehan95@gmail.com", key: SecureRandom.urlsafe_base64(16))

will_user = ransom.users.create!(email: "wsheehan@bates.edu", password: "foobar", first_name: "Will", last_name: "Sheehan")

affiliations = ["Parent", "Student", "Alumni"]

Client.all.each do |client|
	users = FactoryGirl.create_list :user, 4
	users.each { |u| client.users << u }
	40.times do
		a = affiliations.sample
		client.donors.create!(first_name: Faker::Name.first_name,
			last_name: Faker::Name.last_name,
			email: Faker::Internet.email,
			key: SecureRandom.urlsafe_base64(16),
			affiliation: a,
			class_year: (a == "Alumni" ? rand(1960..2015) : nil),
		)
	end
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

# User.all.each do |user|
# 	campaigns = FactoryGirl.create_list :campaign, 7, user_id: user.id
# end

# Campaign for campaign#show
donor_list = ransom.donor_lists.create(donors: ransom.donors.sample(20), title: Faker::Company.buzzword, description: Faker::Lorem.paragraph)
conv_campaign = ransom.campaigns.create(donor_list: donor_list, title: "Test Campaign!", description: Faker::Lorem.paragraph, user: will_user)

designations = ['Annual Fund: Wherever needed most','Annual Fund: Financial Aid', 'Annual Fund: Fine Arts', 'Annual Fund: Technology','Annual Fund: Athletics', 'Annual Fund: Faculty Development', 'Other']
gift_types = ["payment", "pledge_payment", "pledge"]

donor_list.donors.each do |d|
	conv = conv_campaign.campaign_conversions.create(donor: d)
	if rand > 0.6
		conv.update_attributes(gift: ransom.gifts.create!(total: rand(10..1000), donor: d, campaign: conv_campaign, designation: designations.sample, gift_type: gift_types.sample))
		if rand > 0.6
			conv.update_attributes(subscription: true)
		end
	end
end
