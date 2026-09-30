require "test_helper"

class JobSchedulersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_scheduler = job_schedulers(:one)
  end

  test "should get index" do
    get job_schedulers_url
    assert_response :success
  end

  test "should get new" do
    get new_job_scheduler_url
    assert_response :success
  end

  test "should create job_scheduler" do
    assert_difference("JobScheduler.count") do
      post job_schedulers_url, params: { job_scheduler: { description: @job_scheduler.description, name: @job_scheduler.name, submission_rule: @job_scheduler.submission_rule } }
    end

    assert_redirected_to job_scheduler_url(JobScheduler.last)
  end

  test "should show job_scheduler" do
    get job_scheduler_url(@job_scheduler)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_scheduler_url(@job_scheduler)
    assert_response :success
  end

  test "should update job_scheduler" do
    patch job_scheduler_url(@job_scheduler), params: { job_scheduler: { description: @job_scheduler.description, name: @job_scheduler.name, submission_rule: @job_scheduler.submission_rule } }
    assert_redirected_to job_scheduler_url(@job_scheduler)
  end

  test "should destroy job_scheduler" do
    assert_difference("JobScheduler.count", -1) do
      delete job_scheduler_url(@job_scheduler)
    end

    assert_redirected_to job_schedulers_url
  end
end
