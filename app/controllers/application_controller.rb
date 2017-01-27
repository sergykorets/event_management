class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	#protect_from_forgery with: :exception
	#include ActionController::Serialization
	

	def track_activity(trackable, action = params[:action])
		current_user.activities.create! action: action, trackable: trackable
	end

	private

	def define_event
	  @event = Event.find(params[:event_id])
	end

end
