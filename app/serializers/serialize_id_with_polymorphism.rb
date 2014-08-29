module SerializeIdWithPolymorphism
  def self.call(associated_object)
    task_type_parts = associated_object.type.split '::'

    task_type = if task_type_parts.length == 1
                  associated_object.type
                elsif task_type_parts[1] == 'Task'
                  task_type_parts.join('')
                elsif task_type_parts[1] =~ /\A.+Task\z/
                  task_type_parts[1]
                else
                  raise "The task type: '#{associated_object.type}' is not qualified."
                end

    { id: associated_object.id, type: task_type }
  end
end
