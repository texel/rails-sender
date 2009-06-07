require 'test_helper'

class RecipientsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipient" do
    assert_difference('Recipient.count') do
      post :create, :recipient => { }
    end

    assert_redirected_to recipient_path(assigns(:recipient))
  end

  test "should show recipient" do
    get :show, :id => recipients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recipients(:one).to_param
    assert_response :success
  end

  test "should update recipient" do
    put :update, :id => recipients(:one).to_param, :recipient => { }
    assert_redirected_to recipient_path(assigns(:recipient))
  end

  test "should destroy recipient" do
    assert_difference('Recipient.count', -1) do
      delete :destroy, :id => recipients(:one).to_param
    end

    assert_redirected_to recipients_path
  end
end
