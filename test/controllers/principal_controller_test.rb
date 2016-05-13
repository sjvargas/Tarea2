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
  	post :instagram, tag: "beatles", access_token: "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	assert_response 200, msg: "no se retorno estado 200 con parametros"
  end
  
end
