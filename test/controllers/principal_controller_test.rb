require 'test_helper'

class PrincipalControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
  end

  test "sin parametros" do
  	post :instagram
  	assert_response 400, msg: "no se retorno estado 400 sin parametros"
  end

  test "con parametros" do
  	post :instagram, tag: 'beatles'
  	assert_response 200, msg: "no se retorno estado 200 con parametros"
  end
  
end
