require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @expense = expenses(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Expense.count' do
      post :create, expense: { amount: 1 }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Expense.count' do
      delete :destroy, id: @expense
    end
    assert_redirected_to login_url
  end
end
