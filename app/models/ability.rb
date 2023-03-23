class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all # admin can do anything
    else
      can :read, :all # guest user can read everything
      can :manage, Food, food_id: user.id # user can manage their own foods
      can :manage, Recipe, recipe_id: user.id # user can manage their own recipes
      
    end
  end
end
