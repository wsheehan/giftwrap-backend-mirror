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

class Client::Policy < ApplicationRecord
  before_create :add_app_id

  belongs_to :client

  private

    def add_app_id
      self.app_id = "GAI#{SecureRandom.hex(8)}"
    end
end
