require 'test_helper'

class PositionMappersControllerTest < ActionController::TestCase
  setup do
    @position_mapper = position_mappers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:position_mappers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create position_mapper" do
    assert_difference('PositionMapper.count') do
      post :create, position_mapper: @position_mapper.attributes
    end

    assert_redirected_to position_mapper_path(assigns(:position_mapper))
  end

  test "should show position_mapper" do
    get :show, id: @position_mapper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @position_mapper
    assert_response :success
  end

  test "should update position_mapper" do
    put :update, id: @position_mapper, position_mapper: @position_mapper.attributes
    assert_redirected_to position_mapper_path(assigns(:position_mapper))
  end

  test "should destroy position_mapper" do
    assert_difference('PositionMapper.count', -1) do
      delete :destroy, id: @position_mapper
    end

    assert_redirected_to position_mappers_path
  end
end
