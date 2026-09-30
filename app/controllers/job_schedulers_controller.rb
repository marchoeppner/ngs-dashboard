class JobSchedulersController < ApplicationController
  before_action :set_job_scheduler, only: %i[ show edit update destroy ]

  # GET /job_schedulers or /job_schedulers.json
  def index
    @job_schedulers = JobScheduler.all
  end

  # GET /job_schedulers/1 or /job_schedulers/1.json
  def show
  end

  # GET /job_schedulers/new
  def new
    @job_scheduler = JobScheduler.new
  end

  # GET /job_schedulers/1/edit
  def edit
  end

  # POST /job_schedulers or /job_schedulers.json
  def create
    @job_scheduler = JobScheduler.new(job_scheduler_params)

    respond_to do |format|
      if @job_scheduler.save
        format.html { redirect_to @job_scheduler, notice: "Job scheduler was successfully created." }
        format.json { render :show, status: :created, location: @job_scheduler }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @job_scheduler.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /job_schedulers/1 or /job_schedulers/1.json
  def update
    respond_to do |format|
      if @job_scheduler.update(job_scheduler_params)
        format.html { redirect_to @job_scheduler, notice: "Job scheduler was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @job_scheduler }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @job_scheduler.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /job_schedulers/1 or /job_schedulers/1.json
  def destroy
    @job_scheduler.destroy!

    respond_to do |format|
      format.html { redirect_to job_schedulers_path, notice: "Job scheduler was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_scheduler
      @job_scheduler = JobScheduler.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def job_scheduler_params
      params.expect(job_scheduler: [ :name, :description, :submission_rule ])
    end
end
