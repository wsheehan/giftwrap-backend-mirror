class Client::Policy < ApplicationRecord
  before_create :add_app_id

  belongs_to :client

  private

    def add_app_id
      self.app_id = "GAI#{SecureRandom.hex(8)}"
    end
end
