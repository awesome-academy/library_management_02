class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
        can :manage, [User, Author, Publisher, Book, Category, BorrowDetail, Like, Comment]
        can [:read, :accept_request, :deny_request, :create, :edit], Borrow
    else
        can :read, [User, Author, Publisher, Book, Category, Borrow]
        can [:update, :destroy], User, id: user.id
        can [:create, :destroy], Like
        can [:read, :create, :destroy], Comment
        can [:create, :read, :edit, :update, :destroy], Borrow, user_id: user.id
        can [:create, :update, :destroy], BorrowDetail
        cannot [:accept_request, :deny_request], Borrow
    end
end
end
