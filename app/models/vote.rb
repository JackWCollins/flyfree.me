class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :video

	validates_uniqueness_of :user
end