require "test_helper"

class XrefJobLibrariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xref_job_library = xref_job_libraries(:one)
  end

  test "should get index" do
    get xref_job_libraries_url
    assert_response :success
  end

  test "should get new" do
    get new_xref_job_library_url
    assert_response :success
  end

  test "should create xref_job_library" do
    assert_difference("XrefJobLibrary.count") do
      post xref_job_libraries_url, params: { xref_job_library: { job_id: @xref_job_library.job_id, library_id: @xref_job_library.library_id } }
    end

    assert_redirected_to xref_job_library_url(XrefJobLibrary.last)
  end

  test "should show xref_job_library" do
    get xref_job_library_url(@xref_job_library)
    assert_response :success
  end

  test "should get edit" do
    get edit_xref_job_library_url(@xref_job_library)
    assert_response :success
  end

  test "should update xref_job_library" do
    patch xref_job_library_url(@xref_job_library), params: { xref_job_library: { job_id: @xref_job_library.job_id, library_id: @xref_job_library.library_id } }
    assert_redirected_to xref_job_library_url(@xref_job_library)
  end

  test "should destroy xref_job_library" do
    assert_difference("XrefJobLibrary.count", -1) do
      delete xref_job_library_url(@xref_job_library)
    end

    assert_redirected_to xref_job_libraries_url
  end
end
