class GiftSerializer < ActiveModel::Serializer
  attributes :id, :total

  belongs_to :donor, serializer: DonorSerializer
end
