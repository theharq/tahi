class AuthorDirector < Director
  attr_reader :author

  def initialize(author=nil)
    @author = author
  end

  def create(params)
    @author = Author.create(author_params)
  end

  def update(params)
    author.update(params)
  end

  def destroy
    author.destroy
  end
end
