require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "renders sign in page" do
    get new_user_session_path

    assert_response :success
    assert_select "h1", "로그인"
    assert_select "form[action='#{user_session_path}']"
  end

  test "user can sign in with email and password" do
    post user_session_path, params: {
      user: {
        email: users(:one).email,
        password: "password123"
      }
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_select "p", /#{users(:one).email}/
  end

  test "redirects guest to sign in" do
    get home_index_url
    assert_redirected_to new_user_session_path
  end

  test "signed in user can get index" do
    sign_in users(:one)

    get home_index_url
    assert_response :success
  end
end
