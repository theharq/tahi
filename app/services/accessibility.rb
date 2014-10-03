class Accessibility

  attr_accessor :resource, :action

  def initialize(resource, action=nil)
    @resource = resource
    @action = action
  end

  def connected_users
    policy.connected_users
  end

  def users
    action.present? ? filtered_users(action) : connected_users
  end


  private

  def filtered_users(filter)
    connected_users.map do |user|
      user if policy(user).send(action)
    end.uniq
  end

  def policy(user=nil)
    #TODO: do not hardcode paper attr
    policy_klass.new(current_user: user, paper: resource)
  end

  def policy_klass
    "#{resource.class.name.pluralize}Policy".constantize
  end

end
