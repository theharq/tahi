class PaperToken
  def initialize(paper_id:)
    @paper = Paper.find(paper_id)
  end

  def generate
    PaperToken.verifier.generate([@paper.id, 1.month.from_now])
  end

  # entry to consume
  def self.deserialize(token)
    verifier.verify(token)
  end

  def self.valid?(token)
    paper_id, expiration_date = deserialize(token)

    return false if Time.now > expiration_date
    return Paper.find_by_id(paper_id) || false
  end

  def self.verifier
    Rails.application.message_verifier(ENV.fetch("RAILS_SECRET_TOKEN"))
  end
end
