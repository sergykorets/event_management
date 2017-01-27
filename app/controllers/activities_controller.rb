class ActivitiesController < ApplicationController

	def index
		@activities = Activity.related_with?(current_user).order("created_at desc")
	end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def activities_params
      params.require(:activity).permit(:action, :trackable)
    end

end
