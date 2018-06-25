require "application_system_test_case"

class StaticdcsTest < ApplicationSystemTestCase
  setup do
    @staticdc = staticdcs(:one)
  end

  test "visiting the index" do
    visit staticdcs_url
    assert_selector "h1", text: "Staticdcs"
  end

  test "creating a Staticdc" do
    visit staticdcs_url
    click_on "New Staticdc"

    fill_in "Address", with: @staticdc.address
    fill_in "Name", with: @staticdc.name
    fill_in "Public", with: @staticdc.public
    click_on "Create Staticdc"

    assert_text "Staticdc was successfully created"
    click_on "Back"
  end

  test "updating a Staticdc" do
    visit staticdcs_url
    click_on "Edit", match: :first

    fill_in "Address", with: @staticdc.address
    fill_in "Name", with: @staticdc.name
    fill_in "Public", with: @staticdc.public
    click_on "Update Staticdc"

    assert_text "Staticdc was successfully updated"
    click_on "Back"
  end

  test "destroying a Staticdc" do
    visit staticdcs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Staticdc was successfully destroyed"
  end
end
