class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :update, to: :modify
    user ||= User.new # guest user (not logged in)
    if user.superadmin?
      can :manage, :all
      can :view_reports
      cannot :write_tech_notice, Device
      can :view_purchase_price, Product
      cannot [:edit, :post], [Purchase, RevaluationAct, Sale, MovementAct], status: [1, 2]
      cannot :unpost, [Purchase, RevaluationAct, Sale, MovementAct], status: [0, 2]
      cannot :destroy, [Purchase, RevaluationAct, Sale, MovementAct], status: 1
    elsif user.admin?
      can :manage, :all
      can :view_reports
      can :finance, User if user.able_to? :manage_salary
      cannot :manage, Salary unless user.able_to? :manage_salary
      cannot :manage_rights, User
      cannot :manage, [BonusType, Bonus]
      cannot [:edit, :destroy], Karma
      cannot :write_tech_notice, Device
      cannot [:edit, :post], [Purchase, RevaluationAct, Sale, MovementAct], status: [1, 2]
      cannot :unpost, [Purchase, RevaluationAct, Sale, MovementAct], status: [0, 2]
      cannot :destroy, [Purchase, RevaluationAct, Sale, MovementAct], status: 1
      cannot :read, CashShift
      cannot :close, CashShift
    elsif user.programmer?
      can :manage, :all
      cannot :manage, Salary unless user.able_to? :manage_salary
      cannot :manage_rights, User
      cannot :manage, [BonusType, Bonus]
      cannot [:edit, :destroy], Karma
    elsif user.synchronizer?
      can :sync, Product
    else
      if user.manager?
        can :manage, :all
        cannot :manage, Salary unless user.able_to? :manage_salary
        cannot :manage_rights, User
        cannot :manage, [BonusType, Bonus]
        cannot [:edit, :destroy], Karma
        cannot :read_tech_notice, Device
        cannot :write_tech_notice, Device
        cannot :destroy, [Client, Device]
      end
      if user.software?
        can :modify, [Device, Client]
        can :create_sale, Device
        can [:issue, :activate, :scan, :find], GiftCertificate
        can :modify, Sale
        can [:choose, :select], Product
        can [:post, :edit, :attach_gift_certificate, :return_check], Sale, status: 0
        can [:create, :read], Sale
        can :create, CashOperation
      end
      if user.media?
        can :modify, [Device, Client, Order]
      end
      if user.marketing?
        can :modify, Info
        can :manage, Price
        can :manage, DeviceType
        can :modify, Order
        can :modify, Client
        can :modify, Sale
        can :modify, SalesImport
        cannot :modify, Device
      end
      if user.supervisor?
        can :read, :all
        cannot :update, Device
        cannot :make_announce, Announcement
        cannot :create, Order
        cannot [:modify, :destroy], Comment
      end
      if user.technician?
        can :modify, Order
        can :read_tech_notice, Device
        can :write_tech_notice, Device
        can :repair, Device
        can [:choose, :select], RepairService
      end
      can :manage, WikiPage if user.able_to? :manage_wiki
      can :make_announce, Announcement
      can :close_all, Announcement
      can :close, Announcement do |announcement|
        announcement.visible_for? user
      end
      can [:cancel_announce, :update], Announcement do |announcement|
        user.any_admin? or (announcement.user_id == user.id) or ((announcement.order_done? or announcement.order_status?) and (user.media?))
      end
      can :create, Order
      can :destroy, Order, user_id: user.id
      can :update, Device#, location_id: user.location_id
      can :print_receipt, Device do |device|
        (device.user_id == user.id) or user.any_admin? or user.able_to?(:print_receipt)
      end
      can :profile, User, id: user.id
      can :update_wish, User, id: user.id
      can :duty_calendar, User, id: user.id
      can :update, DeviceTask, task: {role: user.role}#, device: {location_id: user.location_id}#, done: false
      can :create, Comment
      can :update, Comment, user_id: user.id
      can :create, Message
      can :read, Info, recipient_id: [nil, user.id]
      can :rating, User
      can :manage, TimesheetDay if user.able_to? :manage_timesheet
      can :print_check, Sale
      can :read, :all
      cannot [:create, :update, :destroy], StolenPhone
      cannot :read, Salary
      cannot [:edit, :post], [Purchase, RevaluationAct, Sale, MovementAct], status: [1, 2]
      cannot :unpost, [Purchase, RevaluationAct, Sale, MovementAct], status: [0, 2]
      cannot :destroy, [Purchase, RevaluationAct, Sale, MovementAct], status: 1
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
