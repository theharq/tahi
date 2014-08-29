module StandardTasks
  class WhiteboardImagesController < ApplicationController
    respond_to :json

    def create
      image = WhiteboardImage.new(whiteboard_image_params)
      image.save
      respond_with image
    end

    def update
      image = WhiteboardImage.find(params[:id])
      image.update!(whiteboard_image_params)
      respond_with image
    end

    private
    def whiteboard_image_params
      params.require(:whiteboard_image).permit(:data, :task_id)
    end
  end
end
