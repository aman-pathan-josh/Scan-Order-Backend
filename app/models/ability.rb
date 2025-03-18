# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?("superadmin")
      can :manage, :all
    else
      cannot :access, :super_admin_dashboard
    end

    if user.has_role?("admin")
      can :create, Restaurant
      can [ :read, :update, :destroy ], Restaurant, user_restaurants: { user_id: user.id }

      can :create, RestaurantTable
      can [ :read, :update, :destroy ], RestaurantTable, restaurant: { user_restaurants: { user_id: user.id } }

      can :create, MenuItem
      can [ :read, :update, :destroy ], MenuItem, restaurant: { user_restaurants: { user_id: user.id } }

      can [ :read, :destroy ], Review
    end

    if user.has_role?("customer")
      can :read, MenuItem
      can :manage, Order
      can :manage, OrderCart, user_id: user.id
      can :create, Review, user_id: user.id
    end
  end
end
