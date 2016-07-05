
desc "Charge Subscribers"
task subscriptions: :environment do
  subcription_donors = Donor.all.select { |d| d.subscription_start }
  subcription_donors.each do |donor|
    Subscription.each do |sub|
      if donor.gift_frequency == sub.frequency
        target_date = donor.subscription_start + sub.interval.month
        if Date.today == target_date
          payment = Braintree::Transaction.sale(
            customer_id: donor.braintree_customer_id,
            amount: donor.subscription_total
          )
          donor.update_attribute(:subscription_start, Date.today)
        end
      end
    end
  end
end