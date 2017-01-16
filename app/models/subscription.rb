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

class Subscription < ApplicationRecord
  has_many :donors
  belongs_to :school
end
