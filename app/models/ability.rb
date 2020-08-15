class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    if user.present?  # additional permissions for logged in users (they can manage their posts)
      can :manage, Address, user_id: user.id
      if user.admin?  # additional permissions for administrators
        can :manage, :all
      end
    end

  end
end
