class GiftSerializer < ActiveModel::Serializer
  attributes :id, :total, :designation, :gift_type

  belongs_to :donor, serializer: DonorSerializer
end
