class Api::V1::InvitesController < ApiController
	before_action :define_event
	respond_to :json

	# Creating invites
	def create
		@invite = Invite.new(invite_params) # Make a new Invite
	    @invite.sender_id = current_user.id # set the sender to the current user
	    @invite.event_id = @event.id
	    @invite.recipient_id = (User.find_by_email(@invite.email)).id
	    if @invite.save
	      track_activity @invite
	      @invite.recipient.events.push(@invite.event) 
	      render json: @invite, status: 201 
	    else
	      render json: { errors: @invite.errors}, status: 422
	    end
	end

	private

	def invite_params
	   params.require(:invite).permit(:email)
	end
end
