class Comment < ApplicationRecord

	belongs_to :user
	belongs_to :event

	validates_length_of :body, :maximum => 500
end
