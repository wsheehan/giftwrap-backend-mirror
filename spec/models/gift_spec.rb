# == Schema Information
#
# Table name: gifts
#
#  id          :integer          not null, primary key
#  total       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  donor_id    :integer
#  campaign_id :integer
#  designation :string
#  gift_type   :string
#  client_id   :integer
#

require 'rails_helper'

RSpec.describe Gift, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
