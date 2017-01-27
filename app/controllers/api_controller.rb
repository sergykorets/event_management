class ApiController < ActionController::API
	before_action :authenticate_user
	include Knock::Authenticable
	undef_method :current_user

	def track_activity(trackable, action = params[:action])
		current_user.activities.create! action: action, trackable: trackable
	end

	private

	def define_event
	  @event = Event.find(params[:event_id])
	end
end