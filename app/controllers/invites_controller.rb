class InvitesController < ApplicationController
	before_action :define_event

	def new
		@invite = Invite.new
	end

	def create
	   @invite = Invite.new(invite_params) # Make a new Invite
	   @invite.sender_id = current_user.id # set the sender to the current user
	   @invite.event_id = @event.id
	   @invite.recipient_id = (User.find_by_email(@invite.email)).id
	   if @invite.save
	   		@invite.recipient.events.push(@invite.event)
      		respond_to do |format|
				format.html { redirect_to events_path }
				format.json { render json: @invite.id }
			end
	   else
			respond_to do |format|
				format.html { render "new" }
				format.json { render json: @invite.errors }
			end
	   end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
      params[:invite].permit(:email)
    end 

end