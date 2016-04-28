class Gift < ActiveRecord::Base
  belongs_to :school
  belongs_to :donor
end
