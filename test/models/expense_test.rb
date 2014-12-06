require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:vishal)
    @sharing_user = users(:michael)
    # This code is not idiomatically correct.
    @expense = @user.expenses.build(amount: 5.00, description: 'test',
          user_id: @user.id, sharing_user_id: @sharing_user.id)
  end

  test "should be valid" do
    assert @expense.valid?
  end

  test "user ids should be present" do
    @expense.user_id = nil
    @expense.sharing_user_id = nil
    assert_not @expense.valid?
  end

  test "amount should be validated" do
    @expense.amount = 1
    assert @expense.valid?
  end

  test "amounts should be postive" do
    @expense.amount = -1.50
    assert_not @expense.valid?
  end

  test "integers should be less than 10" do
    @expense.amount = 1000.01
    assert_not @expense.valid?
  end

  test "description is optional" do
    @expense.description = ""
    assert @expense.valid?
  end

  test "description should be at most 50 characters" do
    @expense.description = "a" * 51
    assert_not @expense.valid?
  end

  test "order should be recent first" do
    assert_equal Expense.first, expenses(:most_recent)
  end
end
