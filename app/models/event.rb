class Event < ApplicationRecord
	
	has_attached_file :file 
  	#validates_attachment_content_type :file, content_type: /\A(image|application)\/.*\z/
	
	has_many :comments, dependent: :destroy
	has_many :invites, dependent: :destroy
	has_many :memberships
	has_many :activities
	has_many :users, through: :memberships
	belongs_to :owner, :class_name => 'User'

	validates_length_of :purpose, :maximum => 100
	validates_length_of :place, :maximum => 25
	validates :time, presence: true
	validates_datetime :time, :after => lambda { Time.now }, :on => :create

	def has_membership?(user)
		Membership.where(user_id: user.id, event_id: self.id).exists?
	end

end
