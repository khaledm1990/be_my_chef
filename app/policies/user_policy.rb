class UserPolicy
  def edit?
    return true if user.admin?
  end
end
