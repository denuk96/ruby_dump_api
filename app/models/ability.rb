# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, [Post, Category]
    can :manage, Post, user_id: user.id
    if user.id # if user exist in db
      can :create, Post
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
