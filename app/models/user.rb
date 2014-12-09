class User < ActiveRecord::Base
  has_many :expenses, dependent: :destroy
  has_many :active_friends, class_name:  "Friend",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_friends, class_name:  "Friend",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_friends, source: :followed
  has_many :followers, through: :passive_friends, source: :follower
  before_save { self.email = email.downcase }
  validates :uname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    expenses
    # Expense.where("user_id = ?", id)
  end

    # Follows a user.
  def follow(other_user)
    active_friends.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_friends.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end
