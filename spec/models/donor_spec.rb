# == Schema Information
#
# Table name: donors
#
#  id                    :integer          not null, primary key
#  first_name            :string
#  last_name             :string
#  email                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  key                   :string
#  braintree_customer_id :string
#  phone_number          :string
#  gift_frequency        :string
#  subscription_id       :integer
#  subscription_start    :date
#  subscription_total    :string
#  client_id             :integer
#  affiliation           :string
#  class_year            :integer
#  campaign_id           :integer
#

require 'rails_helper'

RSpec.describe Donor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
