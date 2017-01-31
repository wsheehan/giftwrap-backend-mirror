class CampaignSerializer < ActiveModel::Serializer
  attribute :id
  attribute :title
  attribute :description
  attribute :total_raised
  attribute :campaigns_sent
  attribute :campaigns_converted
  attribute :campaign_conversion_rate
  attribute :new_subscriptions

  has_many :gifts, serializer: GiftSerializer
  has_many :top_gifts, serializer: GiftSerializer, key: "top_gifts"
  belongs_to :donor_list, serializer: DonorListSerializer
  belongs_to :user, serializer: UserSerializer
end
