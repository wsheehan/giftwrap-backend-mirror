class Campaign::Email < ApplicationRecord

  # Associations
  belongs_to :campaign

  # Header Image Uploader
  mount_base64_uploader :header_image, EmailHeaderUploader
end
