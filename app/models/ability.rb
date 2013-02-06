class
Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :update, to: :modify
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.programmer?
      can :manage, :all
    else
      if user.software?
        can :modify, [Device, Client]
      end
      if user.media?
        can :modify, [Device, Client]
      end
      if user.marketing?
        can :manage, Price
        can :manage, DeviceType
        can :manage, Order
        can :modify, Client
        cannot :modify, Device
      end
      if user.helpable?
        can :make_announce, Announcement
        can :cancel_announce, Announcement, user_id: user.id
      end
      #can :check_phone_number, Client
      #can :questionnaire, Client
      #can :autocomplete, Client
      #can :select, Client
      can :create, Order
      can :read, Info
      can :update, Device#, location_id: user.location_id
      can :profile, User, id: user.id
      can :update_wish, User, id: user.id
      can :duty_calendar, User, id: user.id
      can :update, DeviceTask, task: {role: user.role}#, device: {location_id: user.location_id}#, done: false
      can :modify, Comment
      can :read, :all
      cannot [:create, :update, :destroy], StolenPhone
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
