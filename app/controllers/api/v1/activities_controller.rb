class Api::V1::ActivitiesController < ApiController
	respond_to :json

	def index
		@activities = Activity.related_with?(current_user).order("created_at desc")
		render json: @activities
	end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def activities_params
      params.require(:activity).permit(:action, :trackable)
    end

end
