class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    can :manage, User

  end
end
