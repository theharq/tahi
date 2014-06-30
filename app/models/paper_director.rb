class PaperDirector
  attr_reader :paper

  def self.add_class_listener(target_method, klass, method_sym)
    Bus.subscribe("paper:#{target_method}", klass, method_sym)
  end

  def initialize(paper)
    @paper = paper
  end

  def add_reviewers(user_ids)
    with_notification(__method__, user_ids: user_ids) do
      user_ids.map do |id|
        PaperRole.reviewers_for(paper).where(user_id: id).create!
      end
    end
  end

  def remove_reviewers(user_ids)
    with_notification(__method__, user_ids: user_ids) do
      PaperRole.reviewers_for(paper).where(user_id: user_ids).destroy_all
    end
  end

  private

  def with_notification(name, context={})
    ActiveRecord::Base.transaction do
      result = yield
      notify(name, context.merge(result: result))
      result
    end
  end

  def notify(message, context={})
    Bus.message("paper:#{message}", context.merge(director: self))
  end

end
