require 'test_helper'

class StaticdcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @staticdc = staticdcs(:one)
  end

  test "should get index" do
    get staticdcs_url
    assert_response :success
  end

  test "should get new" do
    get new_staticdc_url
    assert_response :success
  end

  test "should create staticdc" do
    assert_difference('Staticdc.count') do
      post staticdcs_url, params: { staticdc: { address: @staticdc.address, name: @staticdc.name, public: @staticdc.public } }
    end

    assert_redirected_to staticdc_url(Staticdc.last)
  end

  test "should show staticdc" do
    get staticdc_url(@staticdc)
    assert_response :success
  end

  test "should get edit" do
    get edit_staticdc_url(@staticdc)
    assert_response :success
  end

  test "should update staticdc" do
    patch staticdc_url(@staticdc), params: { staticdc: { address: @staticdc.address, name: @staticdc.name, public: @staticdc.public } }
    assert_redirected_to staticdc_url(@staticdc)
  end

  test "should destroy staticdc" do
    assert_difference('Staticdc.count', -1) do
      delete staticdc_url(@staticdc)
    end

    assert_redirected_to staticdcs_url
  end
end
