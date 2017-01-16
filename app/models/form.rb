# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer
#

class Form < ApplicationRecord
  belongs_to :client
end
