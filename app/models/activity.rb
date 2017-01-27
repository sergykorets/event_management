class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :trackable, polymorphic: true

  def self.related_with?(user)
  	Activity.joins(:event => :memberships).where(memberships: { user_id: user.id })
  end

  before_validation do
  	if self.trackable_type == "Event"
  		self.event_id = self.trackable_id
  	elsif self.trackable_type == "Comment" || self.trackable_type == "Invite"
  		self.event_id = self.trackable.event_id
  	end
  end

end
