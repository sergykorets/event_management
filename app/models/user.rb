class User < ApplicationRecord
	
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	has_many :created_events, class_name: "Event", foreign_key: "owner_id", dependent: :destroy
	has_many :comments
	has_many :created_invites, class_name: "Invite", foreign_key: "sender_id", dependent: :destroy
	has_many :received_invites, class_name: "Invite", foreign_key: "recipient_id", dependent: :nullify
	has_many :memberships
	has_many :events, through: :memberships
	has_many :activities 

	scope :all_except, ->(user) { where.not(id: user) }    
	alias_method :authenticate, :valid_password?

	def self.from_token_payload(payload) 
		self.find payload["sub"]
	end
end
