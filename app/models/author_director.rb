class AuthorDirector
  attr_reader :author

  def initialize(author=nil)
    @author = author
  end

  def create(params)
    with_notification __method__ do
      @author = Author.create(author_params)
    end
  end

  def update(params)
    with_notification __method__ do
      author.update(params)
    end
  end

  def destroy
    with_notification __method__ do
      author.destroy
    end
  end

  private

  def with_notification(name, context={})
    ActiveRecord::Base.transaction do
      result = yield
      if result.destroyed? || result.valid?
        notify(name, context.merge(result: result))
      end
      result
    end
  end

  def notify(message, context={})
    Bus.message("author:#{message}", context.merge(director: self))
  end
end
