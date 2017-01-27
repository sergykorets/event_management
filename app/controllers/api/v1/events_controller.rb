class Api::V1::EventsController < ApiController
	before_action :set_event, only: [:show, :update, :destroy]
	respond_to :json

	def index
		if params[:interval]
			@events = current_user.events.where(:time => Time.now..Time.now + params[:interval].to_i.day)
		elsif params[:due]
			@events = current_user.events.where("time < ?", params[:due])
		else
			@events = current_user.events
		end
		#@events = current_user.events # Event.with_membership(current_user)
		render json: @events
	end

	def show
	    if @event.has_membership?(current_user)
	    	render json: @event, status: 200 
	    else
	     	render json: {
	     		error: "Permission denied"
	     	}, status: 422
	    end
	end

	# Creating users
	def create
		@event = Event.new(event_params)
		@event.owner_id = current_user.id
	    if @event.save
	      current_user.events.push(@event)
	      render json: @event, status: 201 
	    else
	      render json: { errors: @event.errors}, status: 422
	    end
	end

	# Updating users
	def update
		if @event.has_membership?(current_user)
	    	if @event.update(event_params)
	    		track_activity @event
	      		render json: @event, status: 200
	    	else
	      		render json: { errors: @event.errors }, status: 422
	    	end
	    else
	     	render json: {
	     		error: "Permission denied"
	     	}, status: 422
	    end	
	end

	# Deleting users
	def destroy
	    if @event.has_membership?(current_user)
		    @event.destroy
		    track_activity @event
		    head 204
		else
	     	render json: {
	     		error: "Permission denied"
	     	}, status: 422
	    end	    
	end

	private

	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
	   params.require(:event).permit(:time, :purpose, :place)
	end
end
