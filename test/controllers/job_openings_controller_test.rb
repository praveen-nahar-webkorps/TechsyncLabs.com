require "test_helper"

class JobOpeningsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get job_openings_create_url
    assert_response :success
  end
end
