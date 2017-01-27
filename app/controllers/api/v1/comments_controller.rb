class Api::V1::CommentsController < ApiController
  before_action :set_comment, only: [:update, :destroy]
  before_action :define_event
  respond_to :json

  # GET /comments.json
  def index
    if @event.has_membership?(current_user)
      @comments = @event.comments.order("created_at desc")
      render json: @comments
    else
      render json: {
        error: "Permission denied"
      }, status: 422
    end  
  end


  # POST /comments.json
  def create
    if @event.has_membership?(current_user)
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.event_id = @event.id
      if @comment.save
        track_activity @comment
        render json: @comment, status: 201
      else
        render json: { errors: @event.errors, status: :unprocessable_entity }
      end
    else
      render json: {
        error: "Permission denied"
      }, status: 422
    end  
  end


  # PATCH/PUT /comments/1.json
  def update
    if @event.has_membership?(current_user)
      if @comment.update(comment_params)
        track_activity @comment
        render json: @comment, status: 201
      else
        render json: { errors: @event.errors, status: :unprocessable_entity }
      end
    else
      render json: {
        error: "Permission denied"
      }, status: 422
    end  
      
  end


  # DELETE /comments/1.json
  def destroy
    if @event.has_membership?(current_user)
      @comment.destroy
      track_activity @comment
      head 204
    else
      render json: {
        error: "Permission denied"
      }, status: 422
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
