class CampaignSerializer < ActiveModel::Serializer
  attribute :id
  attribute :title
  attribute :description
  attribute :total_raised
  attribute :campaigns_sent
  attribute :campaigns_converted
  attribute :new_subscriptions

  has_many :gifts, serializer: GiftSerializer
  belongs_to :donor_list, serializer: DonorListSerializer
end
