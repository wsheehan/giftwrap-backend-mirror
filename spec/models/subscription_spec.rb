# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  frequency  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  interval   :integer
#  client_id  :integer
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
