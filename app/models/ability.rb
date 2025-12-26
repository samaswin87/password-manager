class Ability
  include CanCan::Ability

  def initialize(user)
    # ---- defaults ----

    return if user.blank? # additional permissions for logged in users (they can manage their posts)

    can :manage, Password
    can :manage, FileImport
    if user.admin? # additional permissions for administrators
      can :manage, :all
    else
      can :show, User, id: user.id
    end
  end
end
