class School < ApplicationRecord
	validates_presence_of :name, :rating, :level

	def gummy_bears
		"I get #{rating * 10} gummy bears because I have a #{rating} out of 10 rating!"		
	end

	def self.by_rating
		order('rating')
	end

	def self.just_high_schools
		where(level: 'high')
	end
end
