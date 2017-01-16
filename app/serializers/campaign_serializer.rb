class CampaignSerializer < ActiveModel::Serializer
  attribute :id
  attribute :total_raised
  attribute :campaigns_sent
  attribute :campaigns_converted
  attribute :new_subscriptions

  has_many :gifts, serializer: GiftSerializer

  def total_raised
    object.total_raised
  end

  def campaigns_sent
    object.campaigns_sent
  end

  def campaigns_converted
    object.campaigns_converted
  end

  def new_subscriptions
    object.new_subscriptions
  end
end
