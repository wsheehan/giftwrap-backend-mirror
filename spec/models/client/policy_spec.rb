# == Schema Information
#
# Table name: client_policies
#
#  id             :integer          not null, primary key
#  app_id         :string           not null
#  app_public_key :string
#  app_secret_key :string
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Client::Policy, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
