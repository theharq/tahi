class NotesController < ApplicationController
  def create
    render json: Note.create!(params.require(:note).permit(:title, :body))
  end
end
