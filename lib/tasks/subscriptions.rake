
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
          if payment.success?
            donor.update_attribute(:subscription_start, Date.today)
          else
            donor.update_attributes(subscription_start: nil, subscription_total: nil, subsciption_id: nil)
            sub.donors.delete(donor)
            # Perhaps send an email to inform the end of the subscription?
          end
        end
      end
    end
  end
end