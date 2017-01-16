# == Schema Information
#
# Table name: campaign_emails
#
#  id           :integer          not null, primary key
#  campaign_id  :integer
#  subject      :string
#  body         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  header_image :string
#

class Campaign::Email < ApplicationRecord

  # Associations
  belongs_to :campaign

  # Header Image Uploader
  mount_base64_uploader :header_image, EmailHeaderUploader
end
