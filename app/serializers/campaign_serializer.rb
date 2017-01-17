class CampaignSerializer < ActiveModel::Serializer
  attribute :id
  attribute :total_raised
  attribute :campaigns_sent
  attribute :campaigns_converted
  attribute :new_subscriptions

  has_many :gifts, serializer: GiftSerializer
end
