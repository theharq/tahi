class AuthorsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    director = AuthorDirector.new
    director.create(author_params)
    respond_with director.author
  end

  def update
    director = AuthorDirector.new(Author.find(params[:id]))
    director.update author_params
    respond_with director.author
  end

  def destroy
    AuthorDirector.new(Author.find(params[:id]))
    director.destroy
    respond_with director.author
  end

  private
  def author_params
    params.require(:author).permit(
      :first_name,
      :last_name,
      :middle_initial,
      :email,
      :title,
      :department,
      :deceased,
      :corresponding,
      :affiliation,
      :secondary_affiliation,
      :author_group_id,
      :position
    )
  end
end
