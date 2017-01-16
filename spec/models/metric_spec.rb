# == Schema Information
#
# Table name: metrics
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Metric, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
