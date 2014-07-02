module FinancialDisclosure
  class Task < ::Task
    title "Financial Disclosure"
    role "author"
    has_many :funders, inverse_of: :task

    def self.author_created(context)
      puts "YAY!"
    end
  end
end
