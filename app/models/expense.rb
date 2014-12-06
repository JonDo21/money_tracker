class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :sharing_user,
    class_name: 'User'
  after_initialize :defaults
  default_scope -> { order(created_at: :desc) }
  validates :user, presence: true
  validates :amount, presence: true,
    :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
      :numericality => { :greater_than => 0, :less_than => 1000 }
  validates :description, length: { minimum: 0, maximum: 50 }

  def defaults
    self.description ||= ''
    self.sharing_user ||= self.user
  end
end
