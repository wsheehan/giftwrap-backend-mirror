
desc "Charge Subscribers"
task subscriptions: :environment do
  subcription_donors = Donor.all.select { |d| d.subscription_date }
  subcription_donors.each do |donor|
    Subscription.each do |sub|
      if donor.gift_frequency == sub.frequency
        target_date = donor.subscription_date + sub.interval.month
        if Date.today == target_date
          payment = Braintree::Transaction.sale(
            customer_id: donor.braintree_customer_id,
            amount: donor.subscription_total
          )
        end
      end
    end
  end
end