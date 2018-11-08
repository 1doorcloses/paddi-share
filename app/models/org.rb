# == Schema Information
#
# Table name: orgs
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Org < ApplicationRecord
	has_many :leagues
	validates :name, presence: true, length: { maximum: 99 } 
end
