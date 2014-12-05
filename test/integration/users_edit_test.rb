require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { fname:  "",
                                    lname: "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    uname  = "foobar"
    fname = "foo"
    lname = "bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { uname:  uname,
                                    fname: fname,
                                    lname: lname,
                                    email: email,
                                    password:              "foobar",
                                    password_confirmation: "foobar" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.uname,  uname
    assert_equal @user.fname,  fname
    assert_equal @user.lname,  lname
    assert_equal @user.email, email
  end
end
