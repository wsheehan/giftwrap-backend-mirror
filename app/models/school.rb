# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  designation :string           is an Array
#

class School < ApplicationRecord
  belongs_to :client
end
