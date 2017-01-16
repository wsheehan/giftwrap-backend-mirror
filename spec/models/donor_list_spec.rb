# == Schema Information
#
# Table name: donor_lists
#
#  id          :integer          not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#  description :string
#

require 'rails_helper'

RSpec.describe DonorList, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
