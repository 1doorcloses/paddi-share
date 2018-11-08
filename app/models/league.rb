# == Schema Information
#
# Table name: leagues
#
#  id         :bigint(8)        not null, primary key
#  org_id     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class League < ApplicationRecord
	belongs_to :org
	has_and_belongs_to_many :players

	validates :name, presence: true, length: { maximum: 99 }  
end
