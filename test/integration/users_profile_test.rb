require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.uname)
    assert_select 'h1', text: @user.fname
    assert_select 'h1>img.gravatar'
    assert_match @user.expenses.count.to_s, response.body
    @user.expenses.paginate(page: 1).each do |expense|
      assert_match expense.amount, response.body
    end
  end
end
