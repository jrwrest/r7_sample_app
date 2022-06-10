require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation",    mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["no_reply@spotmymeal.com"],      mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),   mail.body.encoded
  end

  # test "password_rest" do
  #   mail = UserMailer.password_rest
  #   assert_equal "Password rest", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
